# Tide renders prompt items in a non-interactive background fish process, so
# item overrides must be available there too.

function _tide_item_gcloud
    set -q CLOUDSDK_CONFIG || set -l CLOUDSDK_CONFIG ~/.config/gcloud
    path is $CLOUDSDK_CONFIG/active_config
    and read -l config <$CLOUDSDK_CONFIG/active_config
    and path is $CLOUDSDK_CONFIG/configurations/config_$config
    and string match -qr '^\s*project\s*=\s*(?<project>.*)' <$CLOUDSDK_CONFIG/configurations/config_$config
    and _tide_print_item gcloud $tide_gcloud_icon' ' (string shorten -m 28 $project)
end

function _tide_item_kubectl
    kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null | read -l raw
    or return

    set -l parts (string split -m 1 / $raw)
    set -l context $parts[1]
    set -l namespace $parts[2]

    if string match -qr '^gke_[^_]+_[^_]+_(?<cluster>.+)$' $context
        set context $cluster
    end

    set context (string shorten -m 32 $context)

    if test -n "$namespace"; and test "$namespace" != default
        _tide_print_item kubectl $tide_kubectl_icon' ' "$context/$namespace"
    else
        _tide_print_item kubectl $tide_kubectl_icon' ' $context
    end
end

status is-interactive; or exit 0

type -q atuin; and atuin init fish | source

if type -q mise
    function mise
        if test (count $argv) -eq 0
            command mise
            return
        end
        switch $argv[1]
            case deactivate shell sh
                command mise $argv | source
            case '*'
                command mise $argv
        end
    end
end

if type -q zoxide
    function z
        functions -e z
        zoxide init fish | source
        z $argv
    end
end

function __lazy_gcloud_init
    functions -e gcloud gsutil __lazy_gcloud_init
    test -f $HOME/google-cloud-sdk/path.fish.inc
    and source $HOME/google-cloud-sdk/path.fish.inc
end
function gcloud
    __lazy_gcloud_init
    gcloud $argv
end
function gsutil
    __lazy_gcloud_init
    gsutil $argv
end

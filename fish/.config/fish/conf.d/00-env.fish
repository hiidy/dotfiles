set fish_greeting

# mise: skip auto-activate (fork-per-prompt); shims in PATH cover normal use
# (must be set before vendor_conf.d/mise-activate.fish runs — this file loads first)
set -gx MISE_FISH_AUTO_ACTIVATE 0

set -gx GOPATH $HOME/go
set -gx DOCKER_HOST "unix://$HOME/.orbstack/run/docker.sock"
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True

set -gx FZF_DEFAULT_OPTS "--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --color=border:#6c7086,label:#cdd6f4"

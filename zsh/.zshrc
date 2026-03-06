# ------------------------------
# Powerlevel10k Instant Prompt
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# Environment Variables
# ------------------------------
export GOPATH="$HOME/go"
export DOCKER_HOST=unix://$HOME/.orbstack/run/docker.sock
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# ------------------------------
# PATH
# ------------------------------
typeset -U path
path=(
  /opt/homebrew/bin
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $HOME/.antigravity/antigravity/bin
  $HOME/google-cloud-sdk/bin
  $GOPATH/bin
  $path
)
export PATH

# ------------------------------
# Zinit
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1; zinit light zsh-users/zsh-completions

autoload -Uz compinit && compinit
zinit cdreplay -q

zinit ice depth=1; zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting

# ------------------------------
# Zsh History
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ------------------------------
# Tool Init
# ------------------------------
eval "$(atuin init zsh)"
eval "$(mise activate zsh)"

if command -v zoxide >/dev/null 2>&1; then
  z() {
    unfunction z
    eval "$(zoxide init zsh)"
    z "$@"
  }
fi

gcloud() {
  unfunction gcloud gsutil 2>/dev/null
  [ -s "$HOME/google-cloud-sdk/path.zsh.inc" ] && . "$HOME/google-cloud-sdk/path.zsh.inc"
  [ -s "$HOME/google-cloud-sdk/completion.zsh.inc" ] && . "$HOME/google-cloud-sdk/completion.zsh.inc"
  gcloud "$@"
}
gsutil() { gcloud; gsutil "$@" }

# ------------------------------
# Aliases
# ------------------------------
(( $+commands[bat] )) && alias cat='bat'

if (( $+commands[eza])); then
    alias ls='eza'
    alias ll='eza -lh --git'
    alias la='eza -lah --git'
    alias lt='eza --tree --level=2'
fi

(( $+commands[fd] )) && alias f='fd'

if (( $+commands[fzf] && $+commands[fd] )); then
  vf() { local file; file=$(fd . | fzf) && vim "$file" }
fi

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias c='claude'
alias ..='cd ..'
alias ...='cd ../..'

# ------------------------------
# Powerlevel10k Config
# ------------------------------
[[ ! -f ~/dotfiles/zsh/.p10k.zsh ]] || source ~/dotfiles/zsh/.p10k.zsh

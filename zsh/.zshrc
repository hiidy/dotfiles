# ------------------------------
# Environment Variables
# ------------------------------
export GOPATH="$HOME/go"
export DOCKER_HOST=unix://$HOME/.orbstack/run/docker.sock
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CLAUDE_CODE_NO_FLICKER=1

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
  $HOME/tools/verible/bin
  $path
)
export PATH

# ------------------------------
# Plugin Bootstrap (may print on first install — must be before Instant Prompt)
# ------------------------------
ZSH_PLUGINS="$HOME/.zsh/plugins"
[[ -d $ZSH_PLUGINS ]] || mkdir -p "$ZSH_PLUGINS"

zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

if [[ ! -e $ZSH_PLUGINS/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_PLUGINS/powerlevel10k
  make -C $ZSH_PLUGINS/powerlevel10k pkg
fi
if [[ ! -e $ZSH_PLUGINS/zsh-completions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git $ZSH_PLUGINS/zsh-completions
fi
if [[ ! -e $ZSH_PLUGINS/fzf-tab ]]; then
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git $ZSH_PLUGINS/fzf-tab
  zcompile-many $ZSH_PLUGINS/fzf-tab/{fzf-tab.zsh,fzf-tab.plugin.zsh,lib/*.zsh}
fi
if [[ ! -e $ZSH_PLUGINS/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGINS/zsh-syntax-highlighting
  zcompile-many $ZSH_PLUGINS/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
fi
if [[ ! -e $ZSH_PLUGINS/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_PLUGINS/zsh-autosuggestions
  zcompile-many $ZSH_PLUGINS/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi

# ------------------------------
# Powerlevel10k Instant Prompt
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# Completions & Plugins
# ------------------------------
fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump
unfunction zcompile-many

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source $ZSH_PLUGINS/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

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
# Tool Init (cached eval to avoid fork+exec on every startup)
# ------------------------------
_cached_source() {
  local name=$1 cmd=$2 cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/$name.zsh" bin_path="${cmd%% *}"
  bin_path="${commands[$bin_path]}"
  [[ -n "$bin_path" ]] || return 1
  if [[ ! -f "$cache_file" || "$bin_path" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    eval "$cmd" > "$cache_file"
  fi
  source "$cache_file"
}

_cached_source "atuin" "atuin init zsh"
unfunction _cached_source

# mise: shims already in PATH, skip `mise activate` to avoid fork+exec on every prompt.
# Wrapper only needed for `mise shell` / `mise deactivate` (they eval in current shell).
mise() {
  local command="${1:-}"
  if [[ "$#" -eq 0 ]]; then
    command mise
    return
  fi
  shift
  case "$command" in
    deactivate|shell|sh)
      eval "$(command mise "$command" "$@")"
      ;;
    *)
      command mise "$command" "$@"
      ;;
  esac
}

if (( $+commands[zoxide] )); then
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

if (( $+commands[eza] )); then
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

# ------------------------------
# ⚡ Powerlevel10k Instant Prompt
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# PATH 환경변수 설정
# ------------------------------
typeset -U path
path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/bison/bin
  /opt/homebrew/opt/mysql-client/bin
  $path
)
export PATH


# ------------------------------
# SDKMAN Lazy Loading
# ------------------------------
export SDKMAN_DIR="$HOME/.sdkman"

# SDKMAN 명령어들을 함수로 래핑 (NVM 방식과 동일)
_sdkman_lazy_load() {
  unset -f sdk java gradle maven kotlin scala sbt springboot micronaut _sdkman_lazy_load
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
}

# 자주 쓰는 명령어들
sdk() { _sdkman_lazy_load; sdk "$@"; }
java() { _sdkman_lazy_load; java "$@"; }
gradle() { _sdkman_lazy_load; gradle "$@"; }


# ------------------------------
# Zinit 초기화
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------
# Python
# ------------------------------
alias python='python3'
alias py310='python3.10'
alias py312='python3.12'
alias py313='python3.13'

# ------------------------------
# Powerlevel10k
# ------------------------------
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ------------------------------
# Zinit 플러그인
# ------------------------------
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit light zsh-users/zsh-syntax-highlighting

zinit light Aloxaf/fzf-tab
# zinit light wfxr/forgit
# zinit light zsh-users/zsh-history-substring-search

# ------------------------------
# zoxide Lazy Loading
# ------------------------------
if command -v zoxide >/dev/null 2>&1; then
  # z 명령어만 lazy load (zi는 Zinit 것 그대로)
  z() {
    unfunction z
    eval "$(zoxide init zsh)"
    z "$@"
  }
fi

# ------------------------------
# mcfly Lazy Loading
# ------------------------------
eval "$(mcfly init zsh)"


# ------------------------------
# NVM Lazy Loading
# ------------------------------
export NVM_DIR="$HOME/.nvm"

_nvm_lazy_load() {
  unset -f node npm npx nvm _nvm_lazy_load
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

node() { _nvm_lazy_load; node "$@"; }
npm() { _nvm_lazy_load; npm "$@"; }
npx() { _nvm_lazy_load; npx "$@"; }
nvm() { _nvm_lazy_load; nvm "$@"; }

# ------------------------------
# Compinit
# ------------------------------
fpath=($HOME/.docker/completions $fpath)

autoload -Uz compinit && compinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ------------------------------
# Zsh History
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ------------------------------
# Aliases
# ------------------------------
(( $+commands[bat] )) && alias cat='bat'
(( $+commands[eza] )) && alias ls='eza -lh --git'
(( $+commands[fd] )) && alias find='fd'
(( $+commands[rg] )) && alias grep='rg'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if (( $+commands[fzf] && $+commands[fd] )); then
  alias vf='vim $(fd . | fzf)'
fi

# ------------------------------
# Powerlevel10k Config
# ------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
# Created by `pipx` on 2025-11-10 17:35:20
export PATH="$PATH:/Users/jeonbyeong-ung/.local/bin"
export DOCKER_HOST=unix://$HOME/.orbstack/run/docker.sock
export PATH=$PATH:/usr/local/opt/riscv-gnu-toolchain/bin

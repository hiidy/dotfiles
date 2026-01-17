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
  $path
)
export PATH

# ------------------------------
# SDKMAN (Java, Gradle, Spring Boot 등)
# ------------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

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
# 더 나은 대체 명령어들
(( $+commands[bat] )) && alias cat='bat'

# eza (더 나은 ls)
if (( $+commands[eza])); then
    alias ls='eza'
    alias ll='eza -lh --git'
    alias la='eza -lah --git'
    alias lt='eza --tree --level=2'
fi

# fd와 ripgrep - 안전한 alias 이름 사용
(( $+commands[fd] )) && alias f='fd'        # find 대신 f 사용

# git dotfiles 관리
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# fzf + fd 조합 (vim 파일 열기)
if (( $+commands[fzf] && $+commands[fd] )); then
  alias vf='vim $(fd . | fzf)'
fi

alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'

# ------------------------------
# Powerlevel10k Config
# ------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ------------------------------
# Additional PATH
# ------------------------------
export PATH="$PATH:$HOME/.local/bin"
export DOCKER_HOST=unix://$HOME/.orbstack/run/docker.sock
export PATH=$PATH:/usr/local/opt/riscv-gnu-toolchain/bin
# opencode
export PATH=/Users/woong/.opencode/bin:$PATH

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/zsh/.p10k.zsh ]] || source ~/dotfiles/zsh/.p10k.zsh

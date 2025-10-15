
# ------------------------------
# ⚡ Powerlevel10k Instant Prompt (반드시 최상단에 위치)
# ------------------------------
# 이 설정으로 첫 프롬프트가 즉시 표시됩니다
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# PATH 환경변수 설정 (통합 관리)
# ------------------------------
typeset -U path  # PATH 중복 자동 제거
path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/bison/bin
  /opt/homebrew/opt/mysql-client/bin
  $path
)
export PATH

# ------------------------------
# Zinit (Zsh 플러그인 매니저) 설치 및 초기화
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------
# Java 버전 스위처 (개선된 버전)
# ------------------------------
jenv() {
  local version=$1
  local base="/Library/Java/JavaVirtualMachines"
  local new_home=""

  case "$version" in
    8)  new_home="$base/zulu-8.jdk/Contents/Home" ;;
    11) new_home="$base/zulu-11.jdk/Contents/Home" ;;
    17) new_home="$base/amazon-corretto-17.jdk/Contents/Home" ;;
    *)
      echo "Usage: jenv [8|11|17]"
      return 1 ;;
  esac

  # PATH에서 기존 JAVA_HOME/bin 제거
  path=(${path:#$JAVA_HOME/bin})
  
  # 새로운 JAVA_HOME 적용
  export JAVA_HOME="$new_home"
  path=($JAVA_HOME/bin $path)
  export PATH

  echo "✅ JAVA_HOME switched to $JAVA_HOME"
  java -version
}

# 기본 Java 버전 설정
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
path=($JAVA_HOME/bin $path)

# ------------------------------
# Python
# ------------------------------
alias python='python3'
alias py310='python3.10'
alias py312='python3.12'
alias py313='python3.13'

# ------------------------------
# Powerlevel10k 테마
# ------------------------------
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ------------------------------
# Zinit 플러그인
# ------------------------------
# 1. Completions
zinit light zsh-users/zsh-completions

# 3. Autosuggestions
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
# 성능 향상을 위한 autosuggestions 설정
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 4. Syntax Highlighting
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# ------------------------------
# zoxide
# ------------------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ------------------------------
# NVM 
# ------------------------------
export NVM_DIR="$HOME/.nvm"

# NVM 관련 명령어들을 함수로 래핑
for cmd in node npm npx nvm; do
  eval "${cmd}() {
    unfunction node npm npx nvm 2>/dev/null
    [ -s \"$NVM_DIR/nvm.sh\" ] && . \"$NVM_DIR/nvm.sh\"
    [ -s \"$NVM_DIR/bash_completion\" ] && . \"$NVM_DIR/bash_completion\"
    ${cmd} \"\$@\"
  }"
done

# ------------------------------
# Compinit
# ------------------------------
# Docker 및 기타 completion 경로 추가
fpath=($HOME/.docker/completions $fpath)

# Compinit 캐시 관리 (zsh4humans 방식)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  # 24시간에 한 번만 전체 검사
  compinit
else
  # 그 외에는 빠른 로드
  compinit -C
fi

# zinit 자동완성
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ------------------------------
# Zsh History
# ------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY          # 타임스탬프 기록
setopt INC_APPEND_HISTORY        # 즉시 히스토리에 추가
setopt SHARE_HISTORY             # 세션 간 히스토리 공유
setopt HIST_IGNORE_ALL_DUPS      # 모든 중복 제거
setopt HIST_REDUCE_BLANKS        # 불필요한 공백 제거
setopt HIST_VERIFY               # 히스토리 확장 시 편집 기회 제공

# ------------------------------
# alias
# ------------------------------
# 더 나은 CLI 도구들로 기본 명령어 대체 (설치되어 있는 경우에만)
(( $+commands[bat] )) && alias cat='bat'
(( $+commands[eza] )) && alias ls='eza -lh --git'
(( $+commands[fd] )) && alias find='fd'
(( $+commands[rg] )) && alias grep='rg'

if (( $+commands[fzf] && $+commands[fd] )); then
  alias vf='vim $(fd . | fzf)'
fi

# ------------------------------
# Powerlevel10k load
# ------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
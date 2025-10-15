# ==============================================================================
# 🚀 Zsh 설정 최적화 버전
# ==============================================================================

# ------------------------------
# 🧱 PATH 환경변수 설정 (통합 관리)
# ------------------------------
# PATH는 중복 추가를 방지하기 위해 이 섹션에서 통합 관리합니다.
# Homebrew 경로를 최우선으로 설정
export PATH="/opt/homebrew/bin:$PATH"

# Homebrew가 직접 PATH에 연결하지 않는 formula 경로 추가 (e.g., bison)
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# Python 관련 경로 (예: Jupyter) - 필요시 실제 경로로 수정 후 주석 해제
# export PATH="$HOME/.local/bin:$PATH" # pipx나 pip --user로 설치한 경우

# ------------------------------
# 🚀 Zinit (Zsh 플러그인 매니저) 설치 및 초기화
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit 명령어 자동완성
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zmodload zsh/zprof # 성능 분석용

# ------------------------------
# ☕ Java 버전 스위처 (PATH 중복 방지 개선)
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
  export PATH=$(echo "$PATH" | sed -E "s#:$JAVA_HOME/bin##g" | sed -E "s#$JAVA_HOME/bin:##g")

  # 새로운 JAVA_HOME 적용
  export JAVA_HOME="$new_home"
  export PATH="$JAVA_HOME/bin:$PATH"

  echo "✅ JAVA_HOME switched to $JAVA_HOME"
  java -version
}
# 기본 Java 버전 설정
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# ------------------------------
# 🐍 Python 별칭 (alias)
# ------------------------------
alias python='python3'
alias py310='python3.10'
alias py312='python3.12'
alias py313='python3.13'

# ------------------------------
# 🎨 Powerlevel10k 테마
# ------------------------------
zinit ice depth=1
zinit light romkatv/powerlevel10k
# P10k 설정 파일 로드
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ------------------------------
# 🔌 Zinit 플러그인 목록
# ------------------------------
zinit light zsh-users/zsh-completions # 자동완성 기능 강화
zinit light rupa/z                  # 디렉토리 이동 편의 도구 (autojump 대체)

# zsh-autosuggestions (명령어 추천) - 비동기, lazy load로 성능 최적화
zinit ice wait lucid atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# zsh-syntax-highlighting (명령어 하이라이팅) - 항상 마지막에 로드
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# ------------------------------
# 🐳 Docker CLI 자동완성
# ------------------------------
# 하드코딩된 경로를 $HOME으로 변경하여 이식성 확보
fpath=($HOME/.docker/completions $fpath)

# ------------------------------
# 🔄 NVM (Node Version Manager) Lazy-load
# ------------------------------
export NVM_DIR="$HOME/.nvm"
load-nvm() {
  [[ -n "$NVM_LOADED" ]] && return # 이미 로드되었으면 실행 중단
  # node, npm, npx, nvm 명령어 실행 시에만 NVM을 로드
  case "${1:-}" in
    node|npm|npx|nvm) ;;
    *) return ;;
  esac
  export NVM_LOADED=1
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
autoload -U add-zsh-hook
add-zsh-hook preexec load-nvm # 명령 실행 직전에 load-nvm 함수 실행

# ------------------------------
# 📜 Zsh History 설정
# ------------------------------
HISTFILE=~/.zsh_history         # 히스토리 파일 경로
HISTSIZE=100000                 # 메모리에 저장할 히스토리 개수
HISTFILESIZE=100000             # 파일에 저장할 히스토리 개수

# 히스토리 관련 옵션
setopt INC_APPEND_HISTORY       # 명령 실행 즉시 히스토리에 추가
setopt SHARE_HISTORY            # 여러 터미널 세션 간 히스토리 공유
setopt HIST_IGNORE_ALL_DUPS     # 모든 중복 명령어는 하나만 기록
setopt HIST_REDUCE_BLANKS       # 불필요한 공백 제거

# ------------------------------
# ⚡️ 사용자 정의 별칭 (Alias)
# ------------------------------
# 더 나은 CLI 도구들로 기본 명령어 대체
# alias cat='bat'       # https://github.com/sharkdp/bat
# alias ls='eza -lh --git' # https://github.com/eza-community/eza
# alias find='fd'       # https://github.com/sharkdp/fd
# alias grep='rg'       # https://github.com/BurntSushi/ripgrep
# alias du='ncdu'       # https://dev.yorhel.nl/ncdu
# alias df='duf'        # https://github.com/muesli/duf
# alias top='htop'      # https://htop.dev/

# 생산성 별칭
alias vf='vim $(fd . | fzf)' # fzf로 파일 검색 후 vim으로 열기
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jeonbyeong-ung/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# nvim keymap guide

현재 설정을 직접 읽어서 정리한 문서다.

- 기준: 명시적으로 설정된 실제 keymap만 포함
- 제외: 주석 처리된 매핑, `which-key` 그룹 라벨, 플러그인 기본 키 전체 나열
- 전제: `<leader>` 는 `<Space>`

분석에 사용한 핵심 파일:

- `init.lua`
- `lua/custom/keymaps.lua`
- `lua/custom/plugins/snacks.lua`
- `lua/custom/plugins/lsp.lua`
- `lua/custom/plugins/gitsigns.lua`
- `lua/custom/plugins/formatting.lua`
- `lua/custom/plugins/bufferline.lua`
- `after/ftplugin/go.lua`
- `lua/kickstart/plugins/debug.lua`

## 1. 먼저 외울 것

실제로 손이 가장 자주 갈 가능성이 높은 것만 먼저 추렸다.

| Keymap | 언제 쓰나 | 의미 |
| --- | --- | --- |
| `<Space>sf` | 파일 열 때 | 파일 찾기 |
| `<Space>sg` | 프로젝트 전체 검색 | grep 검색 |
| `<Space>sw` | 심볼/단어 추적 | 커서 아래 단어 검색 |
| `<Space><Space>` | 버퍼 많이 열었을 때 | 열린 버퍼 목록 |
| `<Space>e` | 파일 트리 볼 때 | explorer 열기 |
| `<Space>E` | 현재 파일 위치 보고 싶을 때 | explorer에서 현재 파일 reveal |
| `gd` | 코드 따라갈 때 | 정의로 이동 |
| `grr` | 누가 쓰는지 볼 때 | 참조 찾기 |
| `grn` | 이름 바꿀 때 | rename |
| `gra` | 빠른 수정 | code action |
| `<Space>f` | 포맷 강제 실행 | 현재 버퍼 format |
| `<Tab>` / `<S-Tab>` | 버퍼 전환 | 다음/이전 버퍼 |
| `<Space>x` | 버퍼 닫기 | 현재 버퍼 삭제 |
| `<C-s>` | 저장 | 파일 저장 |
| `<C-h/j/k/l>` | 창 이동 | split 간 포커스 이동 |

Go 비중이 높다면 여기에 이것도 바로 추가하면 된다.

| Keymap | 의미 |
| --- | --- |
| `<Space>gi` | import 정리 |
| `<Space>ge` | `if err` 블록 생성 |
| `<Space>gf` | struct 채우기 |

## 2. 일상 작업용

### 검색 / 탐색

이 설정의 중심은 사실상 `snacks.nvim` 이다.

| Keymap | 의미 | 체감 빈도 |
| --- | --- | --- |
| `<Space>sf` | 파일 찾기 | 매우 높음 |
| `<Space>sg` | 전체 grep | 매우 높음 |
| `<Space>sw` | 현재 단어 검색 | 높음 |
| `<Space><Space>` | 버퍼 목록 | 높음 |
| `<Space>e` | explorer 열기 | 높음 |
| `<Space>E` | 현재 파일 reveal | 중간 |
| `<Space>/` | 현재 버퍼 검색 | 높음 |
| `<Space>s/` | 열린 버퍼 전체 검색 | 중간 |
| `<Space>s.` | 최근 파일 | 중간 |
| `<Space>sr` | 이전 검색 재개 | 중간 |
| `<Space>sd` | diagnostics 검색 | 중간 |
| `<Space>sk` | keymap 검색 | 낮음이지만 유용 |
| `<Space>sh` | help 검색 | 낮음이지만 중요 |
| `<Space>ss` | picker 목록 | 낮음 |
| `<Space>sn` | nvim 설정 파일 검색 | 설정 만질 때 높음 |
| `<Space>nh` | 알림 히스토리 | 낮음 |
| `<Space>nc` | 알림 닫기 | 낮음 |

### 편집 / 버퍼 / 창

| Keymap | 의미 |
| --- | --- |
| `<Space>f` | 현재 버퍼 포맷 |
| `<Tab>` | 다음 버퍼 |
| `<S-Tab>` | 이전 버퍼 |
| `<Space>x` | 현재 버퍼 삭제 |
| `<C-s>` | 저장 |
| `<Esc>` | 검색 하이라이트 제거 |
| `<Space>wv` | 세로 split |
| `<Space>ws` | 가로 split |
| `<Space>wc` | 현재 창 닫기 |
| `<Space>wo` | 현재 창만 남기기 |
| `<C-h>` | 왼쪽 창으로 이동 |
| `<C-j>` | 아래 창으로 이동 |
| `<C-k>` | 위 창으로 이동 |
| `<C-l>` | 오른쪽 창으로 이동 |
| `<C-/>` | 내장 터미널 토글 |
| `<Esc><Esc>` | 터미널 모드 종료 |

## 3. LSP 붙은 버퍼에서만

이 키들은 LSP가 attach된 버퍼에서만 켜진다.

| Keymap | 의미 | 우선순위 |
| --- | --- | --- |
| `gd` | 정의로 이동 | 매우 높음 |
| `grr` | 참조 찾기 | 매우 높음 |
| `grn` | rename | 매우 높음 |
| `gra` | code action | 매우 높음 |
| `gri` | 구현으로 이동 | 높음 |
| `grt` | 타입 정의로 이동 | 중간 |
| `gO` | 현재 문서 심볼 | 중간 |
| `gW` | 워크스페이스 심볼 | 중간 |
| `grD` | declaration 이동 | 낮음 |
| `<Space>th` | inlay hint 토글 | 중간 |

메모:

- `gd` 와 `grd` 는 현재 설정에서 사실상 같은 동작이다.
- `K` hover는 별도 재정의 없이 Neovim 기본 동작을 쓴다.

## 4. Git 버퍼에서만

`gitsigns.nvim` keymap은 git 추적 중인 파일에서만 실질적으로 의미가 있다.

| Keymap | 의미 | 우선순위 |
| --- | --- | --- |
| `]c` | 다음 변경 hunk로 이동 | 높음 |
| `[c` | 이전 변경 hunk로 이동 | 높음 |
| `<Space>hp` | hunk 미리보기 | 높음 |
| `<Space>hs` | hunk stage | 높음 |
| `<Space>hr` | hunk reset | 높음 |
| `<Space>hb` | 현재 줄 blame | 중간 |
| `<Space>hd` | index 기준 diff | 중간 |
| `<Space>hD` | 마지막 커밋 기준 diff | 중간 |
| `<Space>hS` | 버퍼 전체 stage | 낮음 |
| `<Space>hR` | 버퍼 전체 reset | 낮음 |
| `<Space>tb` | 현재 줄 blame 표시 토글 | 낮음 |
| `<Space>tD` | 삭제 라인 inline preview | 낮음 |

메모:

- `]c`, `[c` 는 diff 모드에서는 built-in diff 이동으로 fallback 된다.

## 5. Go 파일에서만

이 키들은 `after/ftplugin/go.lua` 에서 `buffer-local` 로 정의된다.
즉, Go 파일에서만 외우면 된다.

| Keymap | 의미 | 체감 빈도 |
| --- | --- | --- |
| `<Space>gi` | imports 정리 | 매우 높음 |
| `<Space>ge` | `if err` 블록 생성 | 높음 |
| `<Space>gf` | struct 채우기 | 높음 |
| `<Space>gs` | switch 채우기 | 중간 |
| `<Space>gTa` | struct tag 추가 | 낮음 |
| `<Space>gTr` | struct tag 제거 | 낮음 |
| `<Space>gTc` | struct tag 초기화 | 낮음 |

실전 기준으로는 `gi`, `ge`, `gf` 세 개부터 익히는 게 맞다.

## 6. 디버깅할 때만

항상 외울 필요는 없지만, Go 디버깅을 자주 하면 가치가 있다.

| Keymap | 의미 |
| --- | --- |
| `<F5>` | 디버그 시작 / 계속 |
| `<F1>` | step into |
| `<F2>` | step over |
| `<F3>` | step out |
| `<F7>` | DAP UI 토글 |
| `<Space>b` | breakpoint 토글 |
| `<Space>B` | 조건부 breakpoint 설정 |

## 7. 지금은 굳이 외우지 않아도 되는 것

아래는 기능은 좋지만 초반 우선순위는 낮다.

- `<Space>ss`, `<Space>sk`, `<Space>sh`
- `<Space>nh`, `<Space>nc`
- `gO`, `gW`, `grD`
- `<Space>hS`, `<Space>hR`
- `<Space>gTa`, `<Space>gTr`, `<Space>gTc`
- 디버깅 F-key 전체

## 8. 헷갈리기 쉬운 포인트

| 항목 | 설명 |
| --- | --- |
| `<Tab>` | 평소에는 버퍼 이동이지만, explorer 안에서는 preview 토글로 동작 |
| `<C-h>`, `<C-l>` | explorer 안에서는 일부러 비활성화되어 창 이동 충돌을 피함 |
| `gd` / `grd` | 현재 설정상 같은 정의 이동 |
| `<Space>q` | quickfix가 아니라 diagnostic loclist 열기 |
| `<Space>f` | 수동 format, 별도로 save 시 자동 format도 일부 filetype에서 동작 |

## 9. 현재 설정 기준 추천 암기 순서

1. `<Space>sf`, `<Space>sg`, `<Space><Space>`, `<Space>e`, `<Space>/`
2. `gd`, `grr`, `grn`, `gra`
3. `<Space>f`, `<Tab>`, `<S-Tab>`, `<Space>x`, `<C-s>`
4. `<C-h/j/k/l>`, `<Space>wv`, `<Space>ws`
5. `]c`, `[c`, `<Space>hp`, `<Space>hs`
6. Go를 자주 하면 `<Space>gi`, `<Space>ge`, `<Space>gf`

## 10. 이 문서에서 일부러 뺀 것

아래는 현재 설정에 존재는 하지만 여기서 상세 나열하지 않았다.

- `blink.cmp` 기본 preset 키
- `mini.ai` 기본 텍스트 오브젝트
- `mini.surround` 기본 surround 키

이유는 이 문서가 "현재 네가 자주 쓸 명시적 keymap"에 집중하기 위해서다.
필요하면 다음 단계로 `completion/surround/textobject` 전용 문서를 따로 뽑는 편이 낫다.

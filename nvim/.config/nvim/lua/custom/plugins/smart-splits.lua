return {
  {
    'mrjones2014/smart-splits.nvim',
    -- kitty 통합에 필요: 시작 시 IS_NVIM user_var를 kitty에 세팅해야 하므로
    -- lazy-load 하지 않는 것을 공식 문서가 권장함.
    lazy = false,
    -- alt+hjkl resize용 kitten 설치 (선택)
    build = './kitty/install-kittens.bash',
    opts = {},
  },
}

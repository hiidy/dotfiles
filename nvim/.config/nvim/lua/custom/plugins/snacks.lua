return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      indent = {
        enabled = false,
        char = '│',
        scope = { enabled = true }, -- underline 제거 (시각적 노이즈)
      },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 }, -- 좀 더 빠르게
          easing = 'linear',
        },
      },
      input = { enabled = true },
      terminal = { enabled = true },
      bigfile = { enabled = true },
    },
    keys = {
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history()
        end,
        desc = '알림 히스토리',
      },
      {
        '<leader>nc',
        function()
          Snacks.notifier.hide()
        end,
        desc = '알림 닫기',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal.toggle()
        end,
        desc = '터미널 토글',
      },
    },
  },
}

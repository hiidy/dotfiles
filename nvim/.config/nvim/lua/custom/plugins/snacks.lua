return {
  {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = {
        enabled = true,
        sources = {
          explorer = {
            -- sidebar style file tree
            layout = { preset = 'sidebar', preview = false },
            auto_close = false,
            jump = { close = false },
            follow_file = true,
            tree = true,
            watch = true,
            diagnostics = true,
            diagnostics_open = false,
            git_status = true,
            git_status_open = false,
            git_untracked = true,
            hidden = true,
            ignored = false,
            win = {
              list = {
                keys = {
                  -- 기본 explorer 키맵 + 편의 추가
                  ['<C-h>'] = false, -- 윈도우 이동과 충돌 방지
                  ['<C-l>'] = false,
                  ['<Tab>'] = 'toggle_preview',
                },
              },
            },
          },
        },
      },
      explorer = { enabled = true, replace_netrw = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      indent = {
        enabled = false,
      },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 },
          easing = 'linear',
        },
      },
      input = { enabled = true },
      terminal = { enabled = true },
      bigfile = { enabled = true },
    },
    keys = {
      -- Explorer
      { '<leader>e', function() Snacks.explorer() end, desc = 'File [E]xplorer (cwd)' },
      { '<leader>E', function() Snacks.explorer.reveal() end, desc = 'File [E]xplorer (reveal current file)' },
      -- Search
      { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
      { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
      { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Picker' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord' },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sd', function() Snacks.picker.diagnostics_buffer() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
      { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files' },
      { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Search in current buffer' },
      { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
      { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath 'config' }) end, desc = '[S]earch [N]eovim files' },
      -- Notifier
      { '<leader>nh', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>nc', function() Snacks.notifier.hide() end, desc = 'Dismiss Notifications' },
      -- Terminal
      { '<c-/>', function() Snacks.terminal.toggle() end, desc = 'Toggle Terminal' },
    },
  },
}

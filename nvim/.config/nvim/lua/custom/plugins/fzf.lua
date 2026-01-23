return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      local fzf = require 'fzf-lua'

      -- 1. 기본 설정
      fzf.setup {
        'default-title',
        winopts = {
          preview = {
            scrollbar = 'float',
          },
        },
        keymap = {
          builtin = {
            ['<F1>'] = 'toggle-help',
            ['<F2>'] = 'toggle-fullscreen',
            ['<C-u>'] = 'preview-page-up',
            ['<C-d>'] = 'preview-page-down',
          },
        },
      }

      -- 2. vim.ui.select 대체 (Code Action 등에 사용)
      fzf.register_ui_select()

      -- 3. 키 매핑 설정
      vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf-lua builtin' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

      -- 현재 버퍼 검색
      vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })

      -- 전체 열린 파일에서 Grep
      vim.keymap.set('n', '<leader>s/', function()
        fzf.live_grep {
          cmd = 'git grep --line-number --column --color=always',
          prompt = 'Open Files Grep> ',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- 설정 파일 검색
      vim.keymap.set('n', '<leader>sn', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}

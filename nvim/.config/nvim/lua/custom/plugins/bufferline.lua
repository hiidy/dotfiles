return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.special.bufferline').get_theme(),
    }

    -- 탭 이동
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })

    -- 탭 닫기
    vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true })
  end,
}

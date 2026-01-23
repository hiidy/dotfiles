return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'echasnovski/mini.icons' },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('bufferline').setup {}

    -- 탭 이동
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })

    -- 탭 닫기
    vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true })
  end,
}

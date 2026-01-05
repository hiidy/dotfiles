return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'VeryLazy',
  keys = {
    { '<leader>il', '<cmd>IBLToggle<cr>', desc = 'Toggle indent guides' },
  },
  opts = {
    enabled = false,
    indent = { char = '│' },
    scope = { show_start = true, show_end = true },
  },
}

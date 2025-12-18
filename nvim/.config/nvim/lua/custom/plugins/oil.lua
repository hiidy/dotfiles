-- lua/kickstart/plugins/oil.lua
return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
}

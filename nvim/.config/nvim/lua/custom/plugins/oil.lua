-- lua/kickstart/plugins/oil.lua
return {
  'stevearc/oil.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
  opts = {
    keymaps = {
      -- 충돌 방지만 추가
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  },
}

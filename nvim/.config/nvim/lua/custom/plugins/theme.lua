return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Ghostty 투명도 반영
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        mason = true,
        telescope = { enabled = true },
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}

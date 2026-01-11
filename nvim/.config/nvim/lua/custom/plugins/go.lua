-- lua/plugins/go.lua
return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require('go').setup {
      -- goimports = 'gopls',
      -- gofmt = 'gopls',
      -- lsp_cfg = true,
      -- lsp_gofumpt = true,
      -- lsp_on_attach = true,
      verbose = false,
      diagnostic = { -- set diagnostic to false to disable vim.diagnostic.config setup,
        -- true: default nvim setup
        hdlr = false, -- hook lsp diag handler and send diag to quickfix
        underline = true,
        virtual_text = { spacing = 2, prefix = '' }, -- virtual text setup
        signs = { '', '', '', '' }, -- set to true to use default signs, an array of 4 to specify custom signs
        update_in_insert = false,
      },
      dap_debug = false,
    }
  end,
}

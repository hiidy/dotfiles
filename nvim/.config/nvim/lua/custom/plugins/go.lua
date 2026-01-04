-- lua/plugins/go.lua
return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  event = { 'CmdlineEnter' },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require('go').setup {
      -- goimports = 'gopls',
      -- gofmt = 'gopls',
      -- lsp_cfg = true,
      -- lsp_gofumpt = true,
      -- lsp_on_attach = true,
      dap_debug = false,
    }

    -- 저장 시 자동 포맷
    -- local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   pattern = '*.go',
    --   callback = function()
    --     require('go.format').goimports()
    --   end,
    --   group = format_sync_grp,
    -- })
  end,
}

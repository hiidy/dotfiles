return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    transparent_background = true,
    float = {
      transparent = true,
    },
    styles = {
      comments = { 'italic' },
      keywords = { 'italic' },
    },
    integrations = {
      blink_cmp = true,
      bufferline = true,
      gitsigns = true,
      markdown = true,
      mason = true,
      mini = { enabled = true },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      render_markdown = true,
      semantic_tokens = true,
      snacks = {
        enabled = true,
        indent_scope_color = 'overlay2',
      },
      treesitter = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-nvim'
  end,
}

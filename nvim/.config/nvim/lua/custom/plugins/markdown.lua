return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } },
    anti_conceal = { enabled = true },
    heading = {
      sign = false,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      position = 'inline',
      width = 'block',
      left_pad = 0,
      right_pad = 1,
      border = false,
    },
    code = {
      sign = false,
      width = 'block',
      border = 'hide',
      left_pad = 1,
      right_pad = 1,
      language_pad = 1,
      position = 'right',
    },
    bullet = {
      icons = { '●', '○', '◆', '◇' },
    },
    checkbox = {
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
    },
    quote = { icon = '▋' },
    pipe_table = {
      preset = 'round',
      style = 'full',
    },
    link = {
      enabled = true,
      hyperlink = '󰌹 ',
      email = '󰇮 ',
    },
    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 3,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = '',
      },
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)

    local transparent_groups = {
      'RenderMarkdownH1Bg',
      'RenderMarkdownH2Bg',
      'RenderMarkdownH3Bg',
      'RenderMarkdownH4Bg',
      'RenderMarkdownH5Bg',
      'RenderMarkdownH6Bg',
      'RenderMarkdownCode',
      'RenderMarkdownCodeBorder',
      'RenderMarkdownCodeInline',
      'RenderMarkdownInlineHighlight',
    }

    for _, group in ipairs(transparent_groups) do
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
      if ok then
        hl.bg = nil
        hl.ctermbg = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown' },
      group = vim.api.nvim_create_augroup('markdown-readability', { clear = true }),
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.breakindentopt = ''
        vim.opt_local.showbreak = '  '
        vim.opt_local.spell = false
      end,
    })
  end,
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', desc = '[T]oggle [M]arkdown render' },
  },
}

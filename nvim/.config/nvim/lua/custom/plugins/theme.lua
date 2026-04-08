return {
  'gbprod/nord.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    terminal_colors = true,
    diff = { mode = 'bg' },
    borders = true,
    errors = { mode = 'bg' },
    search = { theme = 'vim' },
    styles = {
      comments = { italic = true },
      keywords = {},
      functions = {},
      variables = {},
      -- transparent 모드에서 플로팅 창도 투명하게
      sidebars = 'transparent',
      floats = 'transparent',
    },
    on_highlights = function(highlights, _)
      -- 기존 kanagawa 설정과 동일한 투명 배경 일관성 유지
      highlights.NormalFloat = { bg = 'NONE' }
      highlights.FloatBorder = { bg = 'NONE' }
      highlights.LazyNormal = { bg = 'NONE' }
      highlights.MasonNormal = { bg = 'NONE' }
      highlights.TelescopeNormal = { bg = 'NONE' }
      highlights.TelescopeBorder = { bg = 'NONE' }
      highlights.WhichKeyFloat = { bg = 'NONE' }
      highlights.SignColumn = { bg = 'NONE' }
    end,
  },
  config = function(_, opts)
    require('nord').setup(opts)
    vim.cmd.colorscheme 'nord'
  end,
}

return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    theme = 'wave',
    transparent = true,
    dimInactive = false, -- transparent 모드에서는 끄는 게 자연스러움
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
    overrides = function(colors)
      return {
        -- 기존 설정
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        NormalDark = { bg = 'none' },
        -- 추가: 더 일관된 투명 배경
        LazyNormal = { bg = 'none' },
        MasonNormal = { bg = 'none' },
        TelescopeNormal = { bg = 'none' },
        TelescopeBorder = { bg = 'none' },
        WhichKeyFloat = { bg = 'none' },
      }
    end,
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd.colorscheme 'kanagawa'
  end,
}

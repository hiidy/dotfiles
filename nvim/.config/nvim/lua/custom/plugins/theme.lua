-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     style = 'storm', -- 'storm', 'moon', 'night', 'day' 중 선택 가능
--     transparent = true, -- Ghostty 투명도 반영
--     styles = {
--       sidebars = 'transparent', -- 사이드바 투명 설정
--       floats = 'transparent',   -- 플로팅 윈도우 투명 설정
--     },
--   },
--   config = function(_, opts)
--     require('tokyonight').setup(opts)
--     vim.cmd.colorscheme 'tokyonight'
--   end,
-- }

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

return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'storm', -- 'storm', 'moon', 'night', 'day' 중 선택 가능
    transparent = true, -- Ghostty 투명도 반영
    styles = {
      sidebars = 'transparent', -- 사이드바 투명 설정
      floats = 'transparent',   -- 플로팅 윈도우 투명 설정
    },
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
}
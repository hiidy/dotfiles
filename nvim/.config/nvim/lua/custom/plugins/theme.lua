return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      transparent = true, -- Ghostty 투명도 반영 필수!
      theme = 'wave', -- wave, dragon, lotus 중 선택
      overrides = function(colors)
        return {
          LineNr = { bg = 'none' },
          SignColumn = { bg = 'none' },
        }
      end,
    }

    vim.cmd.colorscheme 'kanagawa'
  end,
}

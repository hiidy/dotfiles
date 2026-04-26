return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin-nvim",
    },
    extensions = { "lazy", "mason", "quickfix" },
    sections = {
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        "filename",
      },
      lualine_x = { "encoding", "fileformat" },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = { "mode" },
    },
  },
}

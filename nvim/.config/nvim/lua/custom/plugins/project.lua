-- plugins/project.lua
return {
  "DrKJeff16/project.nvim",
  config = function()
    require("project").setup({
      patterns = { "go.mod", ".git", "package.json", "Cargo.toml" },
      fzf_lua = { enabled = true },
    })
  end,
}
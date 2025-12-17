return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    debounce_delay = 1000, -- 1초 후 저장
  },
}

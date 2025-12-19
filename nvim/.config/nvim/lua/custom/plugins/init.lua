-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- 저장/종료 단축키 (VS Code 스타일)
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-q>", "<cmd>q<cr>", { desc = "Quit File" })

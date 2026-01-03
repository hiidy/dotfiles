-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set({ "i", "x", "n", "s" }, "<C-q>", vim.cmd.quit, { desc = "Quit File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", vim.cmd.write, { desc = "Save File" })

vim.keymap.set('n', 's', '')
vim.keymap.set('n', 'sv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', 'sh', '<cmd>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', 'sc', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', 'so', '<C-w>o', { desc = 'Close other windows' })

return {}

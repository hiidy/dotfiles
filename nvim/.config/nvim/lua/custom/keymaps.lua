-- lua/custom/keymaps.lua

local opts = { noremap = true, silent = true }

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-q>", vim.cmd.quit, { desc = "Quit File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", vim.cmd.write, { desc = "Save File" })

vim.keymap.set('n', 's', '')
vim.keymap.set('n', 'sv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', 'sh', '<cmd>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', 'sc', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', 'so', '<C-w>o', { desc = 'Close other windows' })

vim.keymap.set("n", "fe", "<cmd>GoIfErr<CR>", { desc = "Insert if err block" })
vim.keymap.set("n", "fs", "<cmd>GoFillStruct<CR>", { desc = "Fill Struct" })
vim.keymap.set("n", "<leader>fc", "<cmd>GoFillSwitch<CR>", { desc = "Fill Switch" })
vim.keymap.set("n", "<leader>ta", "<cmd>GoAddTag<CR>", { desc = "Add struct tags" })
vim.keymap.set("n", "<leader>tr", "<cmd>GoRmTag<CR>", { desc = "Remove struct tags" })
vim.keymap.set("n", "<leader>tc", "<cmd>GoClearTag<CR>", { desc = "Clear struct tags" })
vim.keymap.set("n", "<leader>i", "<cmd>GoImports<CR>", { desc = "Organize imports" })
-- LSP 키맵은 lsp.lua의 on_attach에서 정의됨 (grn, grd, grr, gri 등)
-- 아래는 추가 편의 키맵
vim.keymap.set("n", "<CR>", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
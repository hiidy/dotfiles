-- lua/custom/keymaps.lua

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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
--  Use CTRL+<hjkl> to switch between windows.
--  smart-splits.nvim을 거쳐 nvim 창 경계를 넘으면 kitty 창으로도 이어서 이동함.
vim.keymap.set('n', '<C-h>', function() require('smart-splits').move_cursor_left() end,  { desc = 'Move focus to the left window (smart-splits)' })
vim.keymap.set('n', '<C-j>', function() require('smart-splits').move_cursor_down() end,  { desc = 'Move focus to the lower window (smart-splits)' })
vim.keymap.set('n', '<C-k>', function() require('smart-splits').move_cursor_up() end,    { desc = 'Move focus to the upper window (smart-splits)' })
vim.keymap.set('n', '<C-l>', function() require('smart-splits').move_cursor_right() end, { desc = 'Move focus to the right window (smart-splits)' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', vim.cmd.write, { desc = 'Save File' })

-- Window 관리 (<leader>w 네임스페이스 — s 접두사는 mini.surround에 양보)
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow [V]ertical split' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>',  { desc = '[W]indow horizontal [S]plit' })
vim.keymap.set('n', '<leader>wc', '<C-w>c',          { desc = '[W]indow [C]lose' })
vim.keymap.set('n', '<leader>wo', '<C-w>o',          { desc = '[W]indow close [O]thers' })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Highlights" })

-- File Explorer
map("n", "<C-n>", "<cmd>20Lex<CR>", { desc = "Open File Explorer" })

-- Options
map("n", "<leader>o", ":so $MYVIMRC<CR>", { desc = "Source Vimrc" })
map("n", "<leader>oe", ":e $MYVIMRC<CR>", { desc = "Edit Vimrc" })

-- Comments
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Line Comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle Comment" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Lower" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Upper" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
map("t", "^[", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })


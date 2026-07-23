vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right Window" })

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.shell = 'bash'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = {
	tab = '» ',
	trail = '·',
	nbsp = '␣'
}

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':so $MYVIMRC<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.pack.add({
	{ src = 'https://github.com/ellisonleao/gruvbox.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

vim.cmd('colorscheme gruvbox')
vim.lsp.enable({ 'lua_ls' })


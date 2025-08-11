vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.shell = 'bash'
vim.o.winborder = 'rounded'

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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

vim.keymap.set('n', '<C-n>', '<cmd>20Lex<CR>')
vim.keymap.set('n', '<leader>o', ':so $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>oe', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>/', 'gcc', {remap = true})
vim.keymap.set('v', '<leader>/', 'gc', {remap = true})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '^[', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.pack.add({
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  -- { src = 'https://github.com/windwp/nvim-autopairs' },
})

vim.cmd('colorscheme gruvbox')
vim.lsp.enable({ 'lua_ls', 'clangd' })
require("ibl").setup()

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

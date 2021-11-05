------------------- IMPORTS ---------------------------------------------------
require('settings')
require('plugins')
require('keys')

require('cfg-lualine')
require('cfg-nvim-cmp')
require('cfg-nvim-lsp')

-------------------- AUTOPAIRS ---------------------------
require('nvim-autopairs').setup{}

-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


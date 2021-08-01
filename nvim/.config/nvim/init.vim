set noshowmode
set laststatus=2

lua << EOF
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- vim.g.python3_host_prog = '/home/cdo/.env/bin/python3'

vim.opt.cursorline     = true                     -- higlinght cursorline
vim.opt.number         = true                     -- show line numbers
vim.opt.number         = true                     -- show line numbers in gutter
vim.opt.pumblend       = 10                       -- pseudo-transparency for popup-menu
vim.opt.relativenumber = true                     -- show relative numbers in gutter
vim.opt.scrolloff      = 3                        -- start scrolling 3 lines before edge of viewport
vim.opt.expandtab      = true                     -- always use spaces instead of tabs

vim.g.hidden           = true                     -- allow buffer switching without prior saving
vim.g.confirm          = true                     -- demand confirmation when closing unsaved buffers

EOF

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

Plug 'morhetz/gruvbox'            "best color scheme
Plug 'scrooloose/nerdtree'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
"Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'hoob3rt/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

syntax on
colorscheme gruvbox
set background=dark    " Setting dark mode

map <C-n> :NERDTreeToggle<CR>

" Telescope settings {{{
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

lua << EOF
-- lualine configuration
local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
EOF


lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    default_config = {
        cmd = {
            "clangd", "--background-index", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
        },
        filetypes = {"c", "cpp", "objc", "objcpp"},
        -- root_dir = require"nvim_lsp/util".root_pattern("compile_commands.json",
                                                       -- "compile_flags.txt",
                                                       -- ".git"),
        init_option = { fallbackFlags = { "-std=c++17" } }
    }
}
EOF

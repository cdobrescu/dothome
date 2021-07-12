" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

Plug 'morhetz/gruvbox'            "best color scheme

" Initialize plugin system
call plug#end()

syntax on
colorscheme gruvbox
set background=dark    " Setting dark mode

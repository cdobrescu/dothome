-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 
    'morhetz/gruvbox',
    config = {
      function()
        vim.cmd 'colorscheme gruvbox'
        vim.g.background = 'dark'
      end
    }
  }

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use { 
    'nvim-lualine/lualine.nvim', 
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require 'cfg.lualine' end
  }

  use {
    "folke/which-key.nvim",
    config = function() require 'cfg.which-key' end
  }

  use { 
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    config = function() require 'cfg.treesitter' end
  }

  use { 
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require 'cfg.telescope' end
  }

  use {
    'simrat39/rust-tools.nvim',
    requires = {'neovim/nvim-lspconfig'},
    config = function() require 'cfg.lsp.rust' end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'onsails/lspkind-nvim', module = 'lspkind' },
      { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp'}, -- LSP completion source for nvim-cmp
      { 'hrsh7th/cmp-path', module = 'cmp_path'}, -- 
      { 'hrsh7th/cmp-buffer', module = 'cmp_buffer'}, -- 
      { 'dcampos/cmp-snippy', module = 'cmp_snippy', 
        requires = {'dcampos/nvim-snippy'}
      }, -- 
    },
    config = function() require 'cfg.cmp' end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

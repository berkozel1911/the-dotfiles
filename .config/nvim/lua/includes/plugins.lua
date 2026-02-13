vim.cmd([[
  call plug#begin('~/.vim/plugged')

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons' 
  Plug 'folke/tokyonight.nvim'
  Plug 'rebelot/kanagawa.nvim'
  Plug 'sainnhe/everforest'
  Plug 'sainnhe/gruvbox-material'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'mason-org/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  call plug#end()
]])

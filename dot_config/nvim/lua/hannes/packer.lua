-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Check if we are running in vscode.
local no_vscode = function()
  return vim.g.vscode == nil
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { { 'nvim-lua/plenary.nvim' } },
    cond = no_vscode
  }

  use({
    "folke/tokyonight.nvim",
    cond = no_vscode
  })

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    cond = no_vscode
  }

  use {
    'theprimeagen/harpoon',
    cond = no_vscode
  }

  use {
    'mbbill/undotree',
    cond = no_vscode
  }

  use {
    'tpope/vim-fugitive',
    cond = no_vscode
  }

  use {
    'neovim/nvim-lspconfig',
    cond = no_vscode
  }
  use { 'hrsh7th/nvim-cmp',
    cond = no_vscode
  }
  use {
    'hrsh7th/cmp-nvim-lsp',
    cond = no_vscode
  }
  use {
    'williamboman/mason.nvim',
    cond = no_vscode
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    cond = no_vscode
  }
  use {
    'L3MON4D3/LuaSnip',
    cond = no_vscode
  }

  use('tpope/vim-surround')

  use {
    'github/copilot.vim',
    cond = no_vscode
  };

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    cond = no_vscode
  }

  use('tomtom/tcomment_vim')

  use {
    'lukas-reineke/indent-blankline.nvim',
    cond = no_vscode
  }

  use {
    'stevearc/conform.nvim',
    cond = no_vscode
  }

  use {
    'eandrju/cellular-automaton.nvim',
    cond = no_vscode
  }

  use {
    'tpope/vim-abolish',
    cond = no_vscode
  }
end)

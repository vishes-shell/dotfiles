local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use 'fedepujol/move.nvim'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  } 

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  }

  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }

  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup()
    end
  }

  use {
    {
      "williamboman/mason.nvim",
      config = function()
        require('mason').setup()
      end
    },
    {
      "williamboman/mason-lspconfig.nvim",
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim'
    },
  }


  use {
    'akinsho/bufferline.nvim', 
    tag = "v2.*", 
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use { "catppuccin/nvim", as = "catppuccin" }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'https://gitlab.com/yorickpeterse/nvim-pqf.git',
    config = function()
      require('pqf')
    end
  }

  use {
    "petertriho/nvim-scrollbar",
    requires = 'kevinhwang91/nvim-hlslens',
    config = function()
      require("scrollbar").setup()
    end
  }

  use { 'glepnir/lspsaga.nvim', branch = 'main' }

  use {
    "neovim/nvim-lspconfig",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use { 
    { 
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
	'telescope-fzf-native.nvim',
      },
      wants = {
        'plenary.nvim',
	'telescope-fzf-native.nvim',
      }
    },
    { 
      'nvim-telescope/telescope-fzf-native.nvim', 
      run = 'make' 
    }
  }

  use { 'lyokha/vim-xkbswitch' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

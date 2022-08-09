local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Essentials
  use {
    'kyazdani42/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  }

  -- Visual
  use {
    'lukas-reineke/indent-blankline.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup()
    end
  }
  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  }
  use {
    'akinsho/bufferline.nvim', 
    tag = "v2.*", 
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    "petertriho/nvim-scrollbar",
    requires = 'kevinhwang91/nvim-hlslens',
    config = function()
      require("scrollbar").setup()
    end
  }
  use { 'rcarriga/nvim-notify' }
  use { "aklt/plantuml-syntax" }
  use { 'weirongxu/plantuml-previewer.vim', requires = 'tyru/open-browser.vim'}

  -- Colors
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Modifications
  use 'fedepujol/move.nvim'
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Linters/formatters
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  } 
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
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
  use { 'preservim/vim-lexical' }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Tags
  use { 'ludovicchabant/vim-gutentags' }

  -- LSP/Completion
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
    'glepnir/lspsaga.nvim', 
    branch = 'main',
  }

  -- Quickfix
  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  }

  -- Telescope
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
    },
    { "nvim-telescope/telescope-file-browser.nvim" }
  }


  -- Keymap
  use { 'lyokha/vim-xkbswitch' }

  -- Tests
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'nvim-neotest/neotest-python',
    }
}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

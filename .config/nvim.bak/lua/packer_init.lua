local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path,
  })
  vim.cmd [[packadd packer.nvim]]
end

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Essentials
  use { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" }

  -- Visual
  use {
    "lukas-reineke/indent-blankline.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
  }
  use {
    "folke/twilight.nvim",
    config = function() require("twilight").setup() end,
  }
  use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
  }
  use { "tpope/vim-fugitive" }
  use {
    "petertriho/nvim-scrollbar",
    requires = "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar").setup()
      require("hlslens").setup({
        calm_down = true,
        nearest_only = true,
        nearest_float_when = "always",
      })
    end,
  }
  use { "rcarriga/nvim-notify" }
  use { "aklt/plantuml-syntax" }
  use { "onsails/lspkind.nvim" }
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function() require("noice").setup() end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim", "rcarriga/nvim-notify",
    },
  })
  use { "RRethy/vim-illuminate" }
  use {
    "shortcuts/no-neck-pain.nvim",
    config = function()
      -- values below are the default
      require("no-neck-pain").setup({
        -- the width of the focused buffer when enabling NNP.
        -- If the available window size is less than `width`, the buffer will take the whole screen.
        width = 120,
        -- When `true`, enables the plugin when you start Neovim.
        enableOnVimEnter = true,
        -- prints useful logs about what event are triggered, and reasons actions are executed.
        debug = false,
      })
    end,
  }

  -- Preview
  use { "weirongxu/plantuml-previewer.vim",
    requires = "tyru/open-browser.vim" }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use({
    "Pocco81/true-zen.nvim",
    config = function() require("true-zen").setup() end,
  })

  -- Colors
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Modifications
  use {
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup({
        mappings = {
          left = "<A-h>",
          right = "<A-l>",
          down = "<A-j>",
          up = "<A-k>",
          line_left = "<A-h>",
          line_right = "<A-l>",
          line_down = "<A-j>",
          line_up = "<A-k>",
        },
      })
    end,
  }
  use {
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup() end,
  }
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  }
  use {
    "https://github.com/nat-418/boole.nvim",
    config = function()
      require("boole").setup({
        mappings = { increment = "<C-a>", decrement = "<C-x>" },
        -- Key value pairs of additional replacements
        -- increment: (key => value)
        -- decrement: (value => key)
        pair_additions = {},
      })
    end,
  }
  use { "dkarter/bullets.vim" }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  }
  use {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        snippet_engine = "luasnip",
        languages = {
          python = {
            template = { annotation_convention = "google_docstrings" },
          },
        },
      }
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  }

  -- Linters/formatters
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use {
    "lewis6991/spellsitter.nvim",
    config = function() require("spellsitter").setup() end,
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
    end,
  }
  use { "preservim/vim-lexical" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Tags
  use { "ludovicchabant/vim-gutentags" }

  -- LSP/Completion
  use {
    "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
  }
  use {
    {
      "williamboman/mason.nvim",
      config = function() require("mason").setup() end,
    }, { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  }
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({
        ui = {
          -- currently only round theme
          theme = "round",
          -- border type can be single,double,rounded,solid,shadow.
          border = "solid",
          winblend = 0,
          expand = "",
          collapse = "",
          preview = "🔍",
          code_action = "💡",
          diagnostic = "🐞",
          incoming = " ",
          outgoing = " ",
          colors = {
            -- float window normal bakcground color
            normal_bg = "#EFF1F5",
            -- title background color
            title_bg = "#afd700",
            red = "#D20F39",
            magenta = "#EA76CB",
            orange = "#FF8700",
            yellow = "#DF8E1D",
            green = "#40A02B",
            cyan = "#36d0e0",
            blue = "#1E66F5",
            purple = "#CBA6F7",
            white = "#BCC0CC",
            black = "#6C6F85",
          },
          kind = {},
        },

      })
    end,
  })

  -- Quickfix
  use { "kevinhwang91/nvim-bqf", ft = "qf" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim", "telescope-fzf-native.nvim" },
    wants = { "plenary.nvim", "telescope-fzf-native.nvim" },
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use({
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        hidden = true,
        respect_gitignore = true,
      })
    end,
  })
  use {
    "debugloop/telescope-undo.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  }
  use {
    "xiyaowong/telescope-emoji.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("emoji")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  }

  -- Files
  use {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        columns = { "icon", "size" },
        restore_win_options = true,
        use_default_keymaps = true,
        view_options = { show_hidden = true },
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 80,
          max_height = 33,
          border = "rounded",
          win_options = { winblend = 10 },
        },
      })
    end,
  }

  -- Keymap
  use { "lyokha/vim-xkbswitch" }

  -- Navigation
  use {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  }

  -- Tests
  use { "vim-test/vim-test" }

  -- Browser
  use {
    "glacambre/firenvim",
    run = function() vim.fn["firenvim#install"](0) end,
  }

  -- -- Notes
  -- use({'jakewvincent/mkdnflow.nvim',
  --   rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
  --   config = function()
  --       require('mkdnflow').setup({})
  --   end
  -- })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require("packer").sync() end
end)

return {
  {
    "cbochs/portal.nvim",
    -- Optional dependencies
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon",
    },
    keys = {
      {
        "<leader>o",
        "<cmd>Portal jumplist backward<cr>",
        desc = "jump backward",
      },
      {
        "<leader>i",
        "<cmd>Portal jumplist forward<cr>",
        desc = "jump forward",
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
      local spider = require("spider")
      vim.keymap.set({ "n", "o", "x" }, "w", function()
        spider.motion("w")
      end, { desc = "Spider-w" })

      vim.keymap.set({ "n", "o", "x" }, "e", function()
        spider.motion("e")
      end, { desc = "Spider-e" })

      vim.keymap.set({ "n", "o", "x" }, "b", function()
        spider.motion("b")
      end, { desc = "Spider-b" })

      vim.keymap.set({ "n", "o", "x" }, "ge", function()
        spider.motion("ge")
      end, { desc = "Spider-ge" })
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    event = "LspAttach",
    opts = { lsp = { auto_attach = true } },
    keys = { { "<leader>cn", "<Cmd>Navbuddy<CR>", desc = "Code breadcrumbs Navigation" } },
  },
  {
    "ludovicchabant/vim-gutentags",
  },
  {
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    keys = {
      {
        "<leader>yfp",
        function()
          require("genghis").copyRelativePath()
        end,
        desc = "Copy relative file path",
      },
      {
        "<leader>yfn",
        function()
          require("genghis").copyFilename()
        end,
        desc = "Copy file name",
      },
      {
        "<leader>rf",
        function()
          require("genghis").renameFile()
        end,
        desc = "Rename file",
      },
      {
        "<leader>mf",
        function()
          require("genghis").moveAndRenameFile()
        end,
        desc = "Move and rename file",
      },
      {
        "<leader>nf",
        function()
          require("genghis").createNewFile()
        end,
        desc = "Create new file",
      },
      {
        "<leader>yff",
        function()
          require("genghis").duplicateFile()
        end,
        desc = "Duplicate file",
      },
    },
  },
  {
    "folke/flash.nvim",
    -- keys = {
    --   {
    --     "q",
    --     mode = { "n", "x", "o" },
    --     function()
    --       vim.cmd([[set keymap=russian-jcukenmac]])
    --       require("flash").jump()
    --       vim.cmd([[set keymap=]])
    --     end,
    --     desc = "Flash RU",
    --   },
    -- },
  },
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    -- or if you are using nixos
    -- build = "nix run .#release",
    opts = {
      -- pass here all the options
    },
    keys = {
      {
        "ff", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files() -- or find_in_git_root() if you only want git files
        end,
        desc = "Open file picker",
      },
    },
  },
}

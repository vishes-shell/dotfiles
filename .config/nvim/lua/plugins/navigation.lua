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
        "<leader>yp",
        function()
          require("genghis").copyFilepath()
        end,
        desc = "Copy file path",
      },
      {
        "<leader>yn",
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
        "<leader>yf",
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
}

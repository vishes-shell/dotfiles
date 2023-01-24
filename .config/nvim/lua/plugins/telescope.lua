return {
  { "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end
    },
    keys = {
      { "<leader>tt", "<cmd>Telescope tags<cr>", desc = "Tags" },
      { "<leader>tb", "<cmd>Telescope current_buffer_tags<cr>", desc = "Tags" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("emoji")
    end,
    opts = {
      defaults = { mappings = { i = {
        ["<C-j>"] = function(...)
          return require('telescope.actions').move_selection_next(...)
        end,
        ["<C-k>"] = function(...)
          return require('telescope.actions').move_selection_previous(...)
        end,
      } } },
      extensions = {
        emoji = {
          action = function(emoji)
            vim.api.nvim_put({ emoji.value }, "c", true, true)
          end,
        },
      },

    }
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    lazy = true,
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("emoji")
    end,
  }
}

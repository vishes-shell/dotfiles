local Util = require("lazyvim.util")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "molecule-man/telescope-menufacture",
        config = function()
          require("telescope").load_extension("menufacture")
        end,
      },
    },
    keys = {
      { "<leader>tt", "<cmd>Telescope tags<cr>", desc = "Tags" },
      { "<leader>tb", "<cmd>Telescope current_buffer_tags<cr>", desc = "Buffer Tags" },
      {
        "<leader>ff",
        function()
          require("telescope").extensions.menufacture.find_files({ hidden = true })
        end,
        desc = "Find Files",
      },
      { "<leader>bs", Util.telescope("lsp_document_symbols"), desc = "LSP Document Symbols" },
      {
        "<leader>/",
        function()
          require("telescope").extensions.menufacture.live_grep({ hidden = true })
        end,
        desc = "Find in Files (Grep)",
      },
      {
        "<leader><space>",
        function()
          require("telescope").extensions.menufacture.find_files({ hidden = true })
        end,
        desc = "Find Files (root dir)",
      },
      {
        "<leader>sw",
        function()
          require("telescope").extensions.menufacture.grep_string({ hidden = true })
        end,
        desc = "Word",
      },

      { "<leader>t<space>", "<cmd>Telescope<cr>", desc = "Base Telescope" },
      {
        "<leader>sD",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "LSP Dynamic Workspace Symbols",
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },
}

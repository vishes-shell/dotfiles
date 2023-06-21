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
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
        dependencies = { "kkharji/sqlite.lua" },
      },
    },
    keys = {
      { "<leader>tt", "<cmd>Telescope tags<cr>", desc = "Tags" },
      { "<leader>tb", "<cmd>Telescope current_buffer_tags<cr>", desc = "Buffer Tags" },
      {
        "<leader>ff",
        Util.telescope(
          "files",
          { hidden = true, glob_pattern = {
            "!**/test_*",
            "!**/.git/*",
          } }
        ),
        desc = "Find Non-test Files",
      },
      {
        "<leader>fF",
        Util.telescope("files", { hidden = true, glob_pattern = { "!**/.git/*" } }),
        desc = "Find All Files",
      },
      { "<leader>bs", Util.telescope("lsp_document_symbols"), desc = "LSP Document Symbols" },
      {
        "<leader>/",
        Util.telescope("live_grep", { hidden = true, glob_pattern = { "!**/test_*.py", "!tests/**" } }),
        desc = "Find in Non-Test Files (Grep)",
      },
      {
        "<leader>?",
        Util.telescope("live_grep", { hidden = true }),
        desc = "Find in All Files (Grep)",
      },
      {
        "<leader><space>",
        Util.telescope("files", { hidden = true, opts = { glob = "!**/test_*.py" } }),
        desc = "Find Files (root dir)",
      },
      {
        "<leader>sw",
        Util.telescope("grep_string", { hidden = true, glob_pattern = { "!**/test_*.py" } }),
        desc = "Word",
      },
      {
        "<leader>sW",
        Util.telescope("grep_string", { hidden = true }),
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

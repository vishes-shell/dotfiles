local Util = require("lazyvim.util")
local telescope = require("telescope")
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      { "<leader>tt", "<cmd>Telescope tags<cr>", desc = "Tags" },
      { "<leader>tb", "<cmd>Telescope current_buffer_tags<cr>", desc = "Buffer Tags" },
      { "<leader>ff", Util.telescope("files", { hidden = true }), desc = "Find Files (root dir)" },
      { "<leader>fF", Util.telescope("files", { hidden = true, cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>bs", Util.telescope("lsp_document_symbols"), desc = "LSP Document Symbols" },
      { "<leader>t<space>", "<cmd>Telescope<cr>", desc = "Base Telescope" },
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
    },
  },
}

-----------------------------------------------------------
-- Telescope configuration file
-----------------------------------------------------------
-- Plugin: telescope
-- url: https://github.com/nvim-telescope/telescope.nvim
local actions = require("telescope.actions")
local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

local default_mappings = {
  i = {
    ["<c-j>"] = actions.move_selection_next,
    ["<c-k>"] = actions.move_selection_previous,

    ["<c-c>"] = actions.close,

    ["<cr>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,

    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,

    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-l>"] = actions.complete_tag,
    ["<C-/>"] = actions.which_key,
    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    ["<C-w>"] = { "<c-s-w>", type = "command" },
    ["<c-t>"] = trouble.open_with_trouble,
  },
  n = {
    ["<esc>"] = actions.close,
    ["<CR>"] = actions.select_default,
    ["<C-j>"] = actions.select_horizontal,
    ["<C-k>"] = actions.select_vertical,

    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

    -- TODO: This would be weird if we switch the ordering.
    ["j"] = actions.move_selection_next,
    ["k"] = actions.move_selection_previous,
    ["H"] = actions.move_to_top,
    ["M"] = actions.move_to_middle,
    ["L"] = actions.move_to_bottom,

    ["<Down>"] = actions.move_selection_next,
    ["<Up>"] = actions.move_selection_previous,
    ["gg"] = actions.move_to_top,
    ["G"] = actions.move_to_bottom,

    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,

    ["<c-t>"] = trouble.open_with_trouble,
    ["?"] = actions.which_key,
  },
}

local opts_cursor = {
  initial_mode = "normal",
  sorting_strategy = "ascending",
  layout_strategy = "cursor",
  results_title = false,
  layout_config = { width = 0.5, height = 0.4 },
}

local opts_vertical = {
  initial_mode = "normal",
  sorting_strategy = "ascending",
  layout_strategy = "vertical",
  results_title = false,
  layout_config = {
    width = 0.3,
    height = 0.5,
    prompt_position = "top",
    mirror = true,
  },
}

telescope.setup {
  defaults = {
    prompt_prefix = "🔍 ",
    mappings = default_mappings,
    dynamic_preview_title = true,
  },
  pickers = {
    buffers = {
      prompt_title = "Buffers",
      mappings = vim.tbl_deep_extend("force", {
        n = { ["d"] = actions.delete_buffer },
      }, default_mappings),
      sort_mru = true,
      preview_title = false,
    },
    lsp_code_actions = vim.tbl_deep_extend("force", opts_cursor, {
      prompt_title = "Code Actions",
    }),
    lsp_range_code_actions = vim.tbl_deep_extend("force", opts_vertical, {
      prompt_title = "Code Actions",
    }),
    lsp_document_diagnostics = vim.tbl_deep_extend("force", opts_vertical, {
      prompt_title = "Document Diagnostics",
      mappings = default_mappings,
    }),
    lsp_implementations = vim.tbl_deep_extend("force", opts_cursor, {
      prompt_title = "Implementations",
      mappings = default_mappings,
    }),
    lsp_definitions = vim.tbl_deep_extend("force", opts_cursor, {
      prompt_title = "Definitions",
      mappings = default_mappings,
    }),
    lsp_references = vim.tbl_deep_extend("force", opts_cursor, {
      prompt_title = "References",
      mappings = default_mappings,
    }),
    find_files = {
      prompt_title = "Files",
      mappings = default_mappings,
      find_command = {
        "rg", "--files", "--color", "never", "--hidden", "-g", "!.git",
        "-g", "!.venv",
      },
    },
    git_files = { prompt_title = "Git Files", mappings = default_mappings },
    live_grep = {
      prompt_title = "Live Ripgrep",
      mappings = default_mappings,
      glob_pattern = { "!.git", "!.venv" },
      additional_args = function(opts) return { "--hidden" } end,
    },
    grep_string = {
      mappings = default_mappings,
      glob_pattern = { "!.git", "!.venv" },
      additional_args = function(opts) return { "--hidden" } end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      hidden = true,
      respect_gitignore = true,
      hijack_netrw = false,
    },
    emoji = {
      action = function(emoji)
        vim.api.nvim_put({ emoji.value }, "c", false, true)
      end,
    },
  },
}

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

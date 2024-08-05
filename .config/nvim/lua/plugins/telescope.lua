return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!{**/.git/*,**/node_modules/*,**/pkg/mod/*,**/yarn.lock,**/.local/*,**/.venv/*}",
      },
    },
  },
  keys = {
    { "<leader>t", "<cmd>Telescope tags<cr>", desc = "Tags" },
    { "<leader>bt", "<cmd>Telescope current_buffer_tags<cr>", desc = "Buffer tags" },
    { "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer fuzzy search" },
  },
}

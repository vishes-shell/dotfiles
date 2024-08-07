return {
  -- Yet another tree-sitter indent plugin for Neovim.
  { "yioneko/nvim-yati", event = "InsertEnter" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "diff",
        "fish",
        "gitignore",
        "vimdoc",
        "html",
        "http",
        "javascript",
        "lua",
        "jsonc",
        "json5",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "vim",
        "yaml",
        "json",
        "gitcommit",
        "rst",
        "tsx",
        "typescript",
      },
      highlight = { enable = true },
      indent = { enable = false },
      yati = {
        enable = true,
        default_lazy = true,
        default_fallback = "auto",
      },
      incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {
          init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
          node_incremental = "<CR>", -- increment to the upper named parent
          scope_incremental = "<nop>", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<BS>", -- decrement to the previous node
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}

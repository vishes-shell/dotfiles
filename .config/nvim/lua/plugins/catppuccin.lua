-----------------------------------------------------------
-- Catppuccin configuration file
-----------------------------------------------------------

-- Plugin: catppuccin
-- url: https://github.com/catppuccin/nvim

vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    cmp = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    ts_rainbow = true,
    notify = true,
    navic = true,
  }
})

vim.cmd [[colorscheme catppuccin]]

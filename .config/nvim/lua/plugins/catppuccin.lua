return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "latte",
      integrations = {
        gitsigns = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        leap = true,
        markdown = true,
        mason = true,
        mini = true,
        neotree = true,
        neotest = true,
        noice = true,
        cmp = true,
        notify = true,
        treesitter_context = true,
        treesitter = true,
        symbols_outline = true,
        telescope = true,
        which_key = true,
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
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
      },
    },
  },
}

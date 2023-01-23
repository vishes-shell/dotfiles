-----------------------------------------------------------
-- Treesitter configuration file
-----------------------------------------------------------

-- Plugin: treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

require("nvim-treesitter.configs").setup {
  ensure_installed = { 'python', 'markdown', 'lua', 'bash', 'sql', 'yaml', 'toml', 'json' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    max_file_lines = nil,
  }
}

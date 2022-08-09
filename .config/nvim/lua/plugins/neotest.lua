-----------------------------------------------------------
-- Neotest configuration file
-----------------------------------------------------------

-- Plugin: neotest
-- url: https://github.com/nvim-neotest/neotest

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "--color=yes", "--reuse-db" }
    }),
  },
})

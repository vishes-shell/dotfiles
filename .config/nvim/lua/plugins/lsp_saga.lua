-----------------------------------------------------------
-- LSP Saga configuration file
-----------------------------------------------------------

-- Plugin: lsp_saga
-- url: https://github.com/glepnir/lspsaga.nvim

local saga = require("lspsaga")

saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false,
  }
})

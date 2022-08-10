-----------------------------------------------------------
-- LSP Saga configuration file
-----------------------------------------------------------

-- Plugin: lsp_saga
-- url: https://github.com/glepnir/lspsaga.nvim

local saga = require("lspsaga")
local kind = require('lspsaga.lspkind')
kind[type_number][2] = icon

saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false,
  }
})

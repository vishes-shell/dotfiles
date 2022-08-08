-----------------------------------------------------------
-- Null-ls configuration file
-----------------------------------------------------------

-- Plugin: null-ls
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.diagnostics.codespell,

  null_ls.builtins.diagnostics.alex,
  null_ls.builtins.formatting.remark,

  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.black,

  null_ls.builtins.diagnostics.vulture,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.pylint,

  null_ls.builtins.diagnostics.yamllint,

  null_ls.builtins.formatting.jq,
}

null_ls.setup({ 
  sources = sources,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    end
    vim.cmd [[
      augroup document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
})

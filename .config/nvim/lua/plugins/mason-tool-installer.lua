-----------------------------------------------------------
-- Mason tool installer configuration file
-----------------------------------------------------------

-- Plugin: mason-tool-installer
-- url: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason-tool-installer').setup({
  ensure_installed = { 
    'alex',
    'codespell',
    'remark',
    'isort',
    'black',
    'vulture',
    'flake8',
    'pylint',
    'semgrep',
    'yamllint',
    'jq',
    'pyright',
    'marksman',
    'lua-language-server',
  }
})

-----------------------------------------------------------
-- Mason tool installer configuration file
-----------------------------------------------------------

-- Plugin: mason-tool-installer
-- url: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason-tool-installer').setup({
  ensure_installed = { 
    'alex',
    'codespell',
    'remark-language-server',
    'isort',
    'black',
    'vulture',
    'flake8',
    'pylint',
    'vulture',
    -- 'semgrep',
    -- 'yamllint',
    -- 'jq',
  }
})

return {
  {
    'esmuellert/vscode-diff.nvim',
    branch = 'next',
    cmd = { 'CodeDiff' },
    keys = {
      { '<leader>gdo', '<cmd>CodeDiff<cr>', desc = 'Open diff view' },
      { '<leader>gdf', '<cmd>CodeDiff file HEAD<cr>', desc = 'File git history' },
      {
        '<leader>gdr',
        function()
          vim.ui.input({ prompt = 'Target branch' }, function(branch)
            if branch then
              vim.cmd('CodeDiff ' .. branch)
            end
          end)
        end,
        desc = 'Review changes with target branch',
      },
    },
    config = function()
      require('vscode-diff').setup({})
    end,
  },
}

return {
  {
    'rcarriga/nvim-notify',
    lazy = true,
    opts = {
      stages = 'static',
      render = 'minimal',
      minimum_width = 10,
    },
    config = function(_, opts)
      local notify = require 'notify'
      notify.setup(opts)
      vim.notify = notify

      vim.api.nvim_set_hl(0, 'NotifyINFOBorder', { fg = '#80ff95' })
      vim.api.nvim_set_hl(
        0,
        'NotifyINFOBody',
        { link = 'NotifyINFOBorder' }
      )
      vim.api.nvim_set_hl(0, 'NotifyWARNBorder', { fg = '#fff454' })
      vim.api.nvim_set_hl(
        0,
        'NotifyWARNBody',
        { link = 'NotifyWARNBorder' }
      )
      vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { fg = '#c44323' })
      vim.api.nvim_set_hl(
        0,
        'NotifyERRORBody',
        { link = 'NotifyERRORBorder' }
      )
    end,
  },
}

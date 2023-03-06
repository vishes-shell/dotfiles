return {
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    config = function()
      local ls = require 'luasnip'
      local types = require 'luasnip.util.types'

      vim.api.nvim_set_hl(
        0,
        'LuasnipChoiceNodePassive',
        { italic = true }
      )
      vim.api.nvim_set_hl(0, 'LuasnipChoiceNodeActive', { bold = true })

      ls.config.set_config {
        history = true,
        region_check_events = 'CursorMoved,CursorHold,InsertEnter',
        delete_check_events = 'InsertLeave',
        ext_opts = {
              [types.choiceNode] = {
            active = {
              virt_text = { { '', 'Operator' } }, -- 
              hl_mode = 'combine',
            },
          },
              [types.insertNode] = {
            active = {
              virt_text = { { '', 'Type' } }, -- 
              hl_mode = 'combine',
            },
          },
        },
        enable_autosnippets = true,
      }

      local function next_choice()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end
      local opts = { silent = true }
      vim.keymap.set('i', '<C-e>', next_choice, opts)
      vim.keymap.set('s', '<C-e>', next_choice, opts)
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
      end,
    }
  }
}

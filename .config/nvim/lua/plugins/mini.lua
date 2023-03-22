return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "cs",
        update_n_lines = "",
        suffix_last = "N",
        suffix_next = "n",
      },
      n_lines = 50,
      search_method = "cover_or_next",
    },
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    init = function()
      local custom_surroundings = {
        markdown = {
          ["B"] = { -- Surround for bold
            input = { "%*%*().-()%*%*" },
            output = { left = "**", right = "**" },
          },
          ["I"] = { -- Surround for italics
            input = { "%_().-()%_" },
            output = { left = "_", right = "_" },
          },
          ["M"] = { -- Surround for monospace
            input = { "%`().-()%`" },
            output = { left = "`", right = "`" },
          },
          ["L"] = {
            input = { "%[().-()%]%([^)]+%)" },
            output = function()
              local href = require("mini.surround").user_input("Href")
              return {
                left = "[",
                right = "](" .. href .. ")",
              }
            end,
          },
          ["R"] = {
            input = { "%[().-()%]%[[^)]+%]" },
            output = function()
              local label = require("mini.surround").user_input("Label")
              return {
                left = "[",
                right = "][" .. label .. "]",
              }
            end,
          },
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dotfiles-mini_surround", {}),
        pattern = vim.fn.join(vim.tbl_keys(custom_surroundings), ","),
        callback = function()
          local ft = vim.opt.filetype:get()
          vim.b.minisurround_config = {
            custom_surroundings = custom_surroundings[ft],
          }
        end,
      })
    end,
  },
}

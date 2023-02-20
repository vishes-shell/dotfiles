return {
  {
    "mickael-menu/zk-nvim",
    lazy = false,
    config = function()
      require("zk").setup({
        picker = "telescope",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
        },
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      })
    end,
    keys = {
      {
        "<leader>zn",
        function()
          vim.ui.select(
            { "daily", "interview", "personal", "meeting", "weekly", "blank" },
            { prompt = "Group" },
            function(group)
              if group then
                vim.ui.input({ prompt = "Title" }, function(title)
                  if title then
                    if group == "blank" then
                      require("zk").new({ title = title })
                    else
                      require("zk").new({ group = group, title = title, dir = group })
                    end
                  end
                end)
              end
            end
          )
        end,
        desc = "Create a new note",
      },
      {
        "<leader>zo",
        "<cmd>ZkNotes { sort = { 'modified' } }<cr>",
        desc = "Open notes",
      },
      { "<leader>zt", "<cmd>ZkTags<cr>", desc = "Open notes associated with the selected tags" },
      {
        "<leader>zf",
        -- function()
        --   vim.ui.input({ prompt = 'Search' }, function(term)
        --     if term then
        --       require('zk').pick_notes({ sort = { 'modified' }, match = { term } })
        --     end
        --   end)
        -- end
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        desc = "Search for the notes matching a given query",
      },
    },
  },
}

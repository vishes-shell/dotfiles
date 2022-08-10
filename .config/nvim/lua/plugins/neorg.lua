-----------------------------------------------------------
-- Neorg configuration file
-----------------------------------------------------------

-- Plugin: neorg
-- url: https://github.com/nvim-neorg/neorg

require('neorg').setup({
    load = {
        ['core.defaults'] = {},
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    work = '~/notes/work',
                    home = '~/notes/home',
                },
                autochdir = true,
                index = "index.norg",
            }
        },
        ['core.norg.concealer'] = {},
        ['core.norg.completion'] = {
            config = {
                engine = "nvim-cmp",
            }
        },
        ['core.norg.journal'] = {},
        ["core.presenter"] = {
            config = {
                zen_mode = "truezen"
            },
        },
    }
})

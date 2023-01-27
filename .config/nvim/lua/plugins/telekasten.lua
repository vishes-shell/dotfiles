return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      { "renerocksai/calendar-vim" },
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      local home = vim.fn.expand("~/zettelkasten")
      local config_path = vim.fn.expand("~/.config/zettelkasten")
      require('telekasten').setup({
        home = home,
        take_over_my_home = true,
        auto_set_filetype = true,
        dailies = home .. '/' .. 'daily',
        weeklies = home .. '/' .. 'weekly',
        templates = config_path .. '/' .. 'templates',
        extension = ".md",
        -- Generate note filenames. One of:
        -- "title" (default) - Use title if supplied, uuid otherwise
        -- "uuid" - Use uuid
        -- "uuid-title" - Prefix title by uuid
        -- "title-uuid" - Suffix title with uuid
        new_note_filename = "title",

        --[[ file UUID type
            - "rand"
            - string input for os.date()
            - or custom lua function that returns a string
        --]]
        uuid_type = "%Y%m%d%H%M",
        -- UUID separator
        uuid_sep = "-",

        -- if not nil, this string replaces spaces in the title when generating filenames
        filename_space_subst = nil,

        -- following a link to a non-existing note will create it
        follow_creates_nonexisting = true,
        dailies_create_nonexisting = true,
        weeklies_create_nonexisting = true,


        -- skip telescope prompt for goto_today and goto_thisweek
        journal_auto_open = false,

        -- template for new notes (new_note, follow_link)
        -- set to `nil` or do not specify if you do not want a template
        template_new_note = config_path .. '/' .. 'templates/new_note.md',

        -- template for newly created daily notes (goto_today)
        -- set to `nil` or do not specify if you do not want a template
        template_new_daily = config_path .. '/' .. 'templates/daily.md',

        -- template for newly created weekly notes (goto_thisweek)
        -- set to `nil` or do not specify if you do not want a template
        template_new_weekly = config_path .. '/' .. 'templates/weekly.md',

        -- image link style
        -- wiki:     ![[image name]]
        -- markdown: ![](image_subdir/xxxxx.png)
        image_link_style = "markdown",

        -- default sort option: 'filename', 'modified'
        sort = "filename",

        -- integrate with calendar-vim
        plug_into_calendar = true,
        calendar_opts = {
          -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
          weeknm = 4,
          -- use monday as first day of week: 1 .. true, 0 .. false
          calendar_monday = 1,
          -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
          calendar_mark = 'left-fit',
        },

        -- telescope actions behavior
        close_after_yanking = false,
        insert_after_inserting = true,

        -- tag notation: '#tag', ':tag:', 'yaml-bare'
        tag_notation = "#tag",

        -- command palette theme: dropdown (window) or ivy (bottom panel)
        command_palette_theme = "dropdown",

        -- tag list theme:
        -- get_cursor: small tag list at cursor; ivy and dropdown like above
        show_tags_theme = "dropdown",

        -- when linking to a note in subdir/, create a [[subdir/title]] link
        -- instead of a [[title only]] link
        subdirs_in_links = true,

        -- template_handling
        -- What to do when creating a new note via `new_note()` or `follow_link()`
        -- to a non-existing note
        -- - prefer_new_note: use `new_note` template
        -- - smart: if day or week is detected in title, use daily / weekly templates (default)
        -- - always_ask: always ask before creating a note
        template_handling = "smart",

        -- path handling:
        --   this applies to:
        --     - new_note()
        --     - new_templated_note()
        --     - follow_link() to non-existing note
        --
        --   it does NOT apply to:
        --     - goto_today()
        --     - goto_thisweek()
        --
        --   Valid options:
        --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
        --              all other ones in home, except for notes/with/subdirs/in/title.
        --              (default)
        --
        --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
        --                    except for notes with subdirs/in/title.
        --
        --     - same_as_current: put all new notes in the dir of the current note if
        --                        present or else in home
        --                        except for notes/with/subdirs/in/title.
        new_note_location = "smart",

        -- should all links be updated when a file is renamed
        rename_update_links = true,

        vaults = {
          vault2 = {
            -- alternate configuration for vault2 here. Missing values are defaulted to
            -- default values from telekasten.
            -- e.g.
            -- home = "/home/user/vaults/personal",
          },
        },

        -- how to preview media files
        -- "telescope-media-files" if you have telescope-media-files.nvim installed
        -- "catimg-previewer" if you have catimg installed
        media_previewer = "telescope-media-files",

        -- A customizable fallback handler for urls.
        follow_url_fallback = nil,
      })
    end,
    keys = {
      { "<leader>zf", function() require('telekasten').find_notes() end, desc = "Find notes by title (filename)" },
      { "<leader>zd", function() require('telekasten').find_daily_notes() end, desc = "Find daily notes by title (date)" },
      { "<leader>zs", function() require('telekasten').search_notes() end, desc = "Search (grep) in all notes" },
      { "<leader>zz", function() require('telekasten').follow_link() end, desc = "Follow the link under the cursor" },
      { "<leader>zT", function() require('telekasten').goto_today() end, desc = "Open today's daily note" },
      { "<leader>zW", function() require('telekasten').goto_thisweek() end, desc = "Open this week's weekly note" },
      { "<leader>zw", function() require('telekasten').find_weekly_notes() end,
        desc = "Find weekly notes by title (calendar week)" },
      { "<leader>zn", function() require('telekasten').new_note() end, desc = "Create a new note" },
      { "<leader>zN", function() require('telekasten').new_templated_note() end, desc = "create a new note by template" },
      { "<leader>zy", function() require('telekasten').yank_notelink() end,
        desc = "Yank a link to the currently open note" },
      { "<leader>zc", function() require('telekasten').show_calendar() end, desc = "Show the calendar" },
      { "<leader>zC", "<cmd>CalendarT<cr>", desc = "Show the calendar" },
      { "<leader>zf", function() require('telekasten').paste_img_and_link() end, desc = "Find notes by title (filename)" },
      { "<leader>zt", function() require('telekasten').toggle_todo() end, desc = "Toggle todo" },
      { "<leader>zf", function() require('telekasten').show_backlinks() end,
        desc = "Show all notes linking to the current one" },
      { "<leader>zF", function() require('telekasten').find_friends() end,
        desc = "Show all notes linking to the link under the cursor" },
      { "<leader>zp", function() require('telekasten').insert_img_link({ i = true }) end,
        desc = "Browse images / media files and insert a link to the selected one" },
      { "<leader>zF", function() require('telekasten').preview_img() end, desc = "preview image under the cursor" },
      { "<leader>zm", function() require('telekasten').browse_media() end, desc = "Browse images / media files" },
      { "<leader>za", function() require('telekasten').show_tags() end, desc = "brings up the tag list" },
      { "<leader>z<space>", function() require('telekasten').panel() end, desc = "brings up the command palette" },
    }
  }
}

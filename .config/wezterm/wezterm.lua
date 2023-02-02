local wezterm = require('wezterm')
return {
  font = wezterm.font("JetBrains Mono"),
  color_scheme = "Catppuccin Latte",
  font_size = 13.0,
  hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },
    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },
    -- Make task numbers clickable
    -- The first matched regex group is captured in $1.
    {
      regex = [[\b(LMSDEV-\d+)\b]],
      format = 'https://jira.skillbox.pro/browse/$1',
    },

  }

}

local wezterm = require('wezterm')
local act = wezterm.action
local mod = "SHIFT|SUPER"

return {
  font = wezterm.font("JetBrains Mono"),
  color_scheme = "Catppuccin Latte",
  font_size = 13.0,
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = false,
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
    -- Make JIRA task numbers clickable
    -- The first matched regex group is captured in $1.
    {
      regex = [[\b(LMSDEV-\d+)\b]],
      format = 'https://jira.skillbox.pro/browse/$1',
    },
    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = "$0",
    },
  },
  -- disable_default_key_bindings = true,
  -- keys = {
  --   { mods = mod, key = "UpArrow", action = act.ActivatePaneDirection("Up") },
  --   { mods = mod, key = "DownArrow", action = act.ActivatePaneDirection("Down") },
  --   { mods = mod, key = "RightArrow", action = act.ActivatePaneDirection("Right") },
  --   { mods = mod, key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
  -- { mods = mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
  --   { mods = mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  --   { mods = mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  --   { mods = mod, key = ">", action = act.MoveTabRelative(1) },
  --   { mods = mod, key = "<", action = act.MoveTabRelative(-1) },
  --   { mods = mod, key = "M", action = act.TogglePaneZoomState },
  --   { mods = mod, key = "p", action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
  --   { mods = mod, key = "C", action = act.CopyTo("ClipboardAndPrimarySelection") },
  --   { mods = mod, key = "l", action = wezterm.action({ ActivateTabRelative = 1 }) },
  --   { mods = mod, key = "h", action = wezterm.action({ ActivateTabRelative = -1 }) },
  --   { key = "C", mods = "CTRL", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
  -- },
  use_dead_keys = false,
  bold_brightens_ansi_colors = true,
  window_background_opacity = 0.95,
  cell_width = 0.9,
  scrollback_lines = 10000,
}

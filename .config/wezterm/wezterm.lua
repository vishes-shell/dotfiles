local wezterm = require('wezterm')
local act = wezterm.action
local mod = "SHIFT|SUPER"

local function font(opts)
  return wezterm.font_with_fallback({
    opts,
    "Symbols Nerd Font Mono",
  })
end

return {
  font = wezterm.font("JetBrains Mono"),
  font_rules = {
    {
      italic = true,
      intensity = "Normal",
      font = font({
        family = "Victor Mono",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Half",
      font = font({
        family = "Victor Mono",
        weight = "DemiBold",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = font({
        family = "Victor Mono",
        weight = "Bold",
        style = "Italic",
      }),
    },
  },
  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = font({ family = "Fira Code", weight = "Bold" }),

    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 11.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "#191b28",

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = "#1e2030",
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  colors = {
    tab_bar = {
      -- The color of the inactive tab bar edge/divider
      inactive_tab_edge = "#1e2030",
      background = "#191b28",
      active_tab = {
        fg_color = "#82aaff",
        bg_color = "#222436",
      },
      inactive_tab = {
        bg_color = "#1e2030",
        fg_color = "#545c7e",
      },
      inactive_tab_hover = {
        bg_color = "#1e2030",
        fg_color = "#82aaff",
      },
      new_tab_hover = {
        fg_color = "#1e2030",
        bg_color = "#82aaff",
      },
      new_tab = {
        fg_color = "#82aaff",
        bg_color = "#191b28",
      },
    },
  },
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
  disable_default_key_bindings = true,
  keys = {
    { mods = mod, key = "UpArrow", action = act.ActivatePaneDirection("Up") },
    { mods = mod, key = "DownArrow", action = act.ActivatePaneDirection("Down") },
    { mods = mod, key = "RightArrow", action = act.ActivatePaneDirection("Right") },
    { mods = mod, key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
    { mods = mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
    { mods = mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = ">", action = act.MoveTabRelative(1) },
    { mods = mod, key = "<", action = act.MoveTabRelative(-1) },
    { mods = mod, key = "M", action = act.TogglePaneZoomState },
    { mods = mod, key = "p", action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
    { mods = mod, key = "C", action = act.CopyTo("ClipboardAndPrimarySelection") },
    { mods = mod, key = "l", action = wezterm.action({ ActivateTabRelative = 1 }) },
    { mods = mod, key = "h", action = wezterm.action({ ActivateTabRelative = -1 }) },
    { key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
    { mods = 'SUPER', key = '-', action = act.DecreaseFontSize },
    { mods = 'SUPER', key = '+', action = act.IncreaseFontSize },
    { mods = 'CTRL', key = 'X', action = act.ActivateCopyMode },
    { mods = mod, key = 's', action = act.ShowTabNavigator },
    { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom('PrimarySelection') },
    { key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom('Clipboard') },
  },
  use_dead_keys = false,
  bold_brightens_ansi_colors = true,
  window_background_opacity = 0.95,
  cell_width = 0.9,
  scrollback_lines = 10000,
}

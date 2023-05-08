local wezterm = require("wezterm")
local act = wezterm.action
local mod = "SHIFT|SUPER"

local function font(opts)
	return wezterm.font_with_fallback({
		opts,
		"Symbols Nerd Font Mono",
	})
end

local process_icons = {
	["docker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["docker-compose"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kuberlr"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kubectl"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["nvim"] = {
		{ Text = wezterm.nerdfonts.custom_vim },
	},
	["vim"] = {
		{ Text = wezterm.nerdfonts.dev_vim },
	},
	["node"] = {
		{ Text = wezterm.nerdfonts.mdi_hexagon },
	},
	["zsh"] = {
		{ Text = wezterm.nerdfonts.dev_terminal },
	},
	["bash"] = {
		{ Text = wezterm.nerdfonts.cod_terminal_bash },
	},
	["btm"] = {
		{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
	},
	["htop"] = {
		{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
	},
	["cargo"] = {
		{ Text = wezterm.nerdfonts.dev_rust },
	},
	["go"] = {
		{ Text = wezterm.nerdfonts.mdi_language_go },
	},
	["lazydocker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["git"] = {
		{ Text = wezterm.nerdfonts.dev_git },
	},
	["lua"] = {
		{ Text = wezterm.nerdfonts.seti_lua },
	},
	["wget"] = {
		{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
	},
	["curl"] = {
		{ Text = wezterm.nerdfonts.mdi_flattr },
	},
	["gh"] = {
		{ Text = wezterm.nerdfonts.dev_github_badge },
	},
}
local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	return wezterm.format(process_icons[process_name] or { { Text = string.format("[%s]", process_name) } })
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local title = string.format(
		" %s  %s ~ %s  ",
		wezterm.nerdfonts.fa_chevron_right,
		get_process(tab),
		get_current_working_dir(tab)
	)

	if has_unseen_output then
		return {
			{ Foreground = { Color = "Orange" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

return {
	audible_bell = "Disabled",
	canonicalize_pasted_newlines = "LineFeed",
	cursor_blink_rate = 500,
	cursor_thickness = 1.5,
	default_cursor_style = "BlinkingBar",
	default_cwd = wezterm.home_dir,
	default_prog = { "/usr/local/bin/fish" },
	font = wezterm.font("JetBrains Mono"),
	font_rules = {
		{
			italic = true,
			intensity = "Normal",
			font = font({
				family = "VictorMono Nerd Font",
				style = "Italic",
			}),
		},
		{
			italic = true,
			intensity = "Half",
			font = font({
				family = "VictorMono Nerd Font",
				weight = "DemiBold",
				style = "Italic",
			}),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font({
				family = "VictorMono Nerd Font",
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
		font = font({ family = "FiraCode Nerd Font", weight = "Bold" }),

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
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},
		-- Make JIRA task numbers clickable
		-- The first matched regex group is captured in $1.
		{
			regex = [[\b(LMSDEV-\d+)\b]],
			format = "https://jira.skillbox.pro/browse/$1",
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
		{ mods = "SUPER", key = "k", action = act.ActivatePaneDirection("Up") },
		{ mods = "SUPER", key = "j", action = act.ActivatePaneDirection("Down") },
		{ mods = "SUPER", key = "l", action = act.ActivatePaneDirection("Right") },
		{ mods = "SUPER", key = "h", action = act.ActivatePaneDirection("Left") },
		{ mods = "SUPER", key = "t", action = act.SpawnTab("CurrentPaneDomain") },
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
		{ mods = "SUPER", key = "-", action = act.DecreaseFontSize },
		{ mods = "SUPER", key = "+", action = act.IncreaseFontSize },
		{ mods = "CTRL", key = "x", action = act.ActivateCopyMode },
		{ mods = mod, key = "s", action = act.ShowTabNavigator },
		{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("PrimarySelection") },
		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
	},
	use_dead_keys = false,
	key_tables = {
		copy_mode = {
			{
				key = "e",
				mods = "NONE",
				action = act.CopyMode("MoveForwardWordEnd"),
			},
		},
	},
	max_fps = 120,
	tab_max_width = 60,
	bold_brightens_ansi_colors = true,
	window_background_opacity = 0.95,
	cell_width = 0.9,
	scrollback_lines = 10000,
}

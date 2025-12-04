local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.log_info("reloading")

-- base
config.front_end = "WebGpu"
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.use_ime = false
config.webgpu_power_preference = "HighPerformance"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.underline_thickness = 3
config.cursor_thickness = 2
config.underline_position = -6

config.initial_cols = 160
config.initial_rows = 50

-- config.term = "wezterm"
config.window_decorations = "RESIZE"

-- fonts
config.font_size = 12
config.font = wezterm.font("JetBrains Mono")
config.bold_brightens_ansi_colors = true
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "VictorMono Nerd Font",
			style = "Italic",
		}),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font({
			family = "VictorMono Nerd Font",
			weight = "DemiBold",
			style = "Italic",
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "VictorMono Nerd Font",
			weight = "Bold",
			style = "Italic",
		}),
	},
}

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.scrollback_lines = 10000

--
-- Tabs
--
local tabs_M = {}
tabs_M.arrow_solid = ""
tabs_M.arrow_thin = ""
tabs_M.icons = {
	["Topgrade"] = wezterm.nerdfonts.md_rocket_launch,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["fish"] = wezterm.nerdfonts.md_fish,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.md_chart_areaspline,
	["btop"] = wezterm.nerdfonts.md_chart_areaspline,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["pacman"] = "󰮯 ",
	["paru"] = "󰮯 ",
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["pwsh.exe"] = wezterm.nerdfonts.md_console,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["lazygit"] = wezterm.nerdfonts.cod_github,
}

---@param tab MuxTabObj
---@param max_width number
function tabs_M.title(tab, max_width)
	local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
	local process, other = title:match("^(%S+)%s*%-?%s*%s*(.*)$")

	if tabs_M.icons[process] then
		title = tabs.M.icons[process] .. " " .. (other or "")
	end

	local is_zoomed = false
	for _, pane in ipairs(tab.panes) do
		if pane.is_zoomed then
			is_zoomed = true
			break
		end
	end
	if is_zoomed then -- or (#tab.panes > 1 and not tab.is_active) then
		title = " " .. title
	end

	title = wezterm.truncate_right(title, max_width - 3)
	return " " .. title .. " "
end

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.unzoom_on_switch_pane = true

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tabs_M.title(tab, max_width)
	local colors = config.resolved_palette
	local active_bg = colors.tab_bar.active_tab.bg_color
	local inactive_bg = colors.tab_bar.inactive_tab.bg_color

	local tab_idx = 1
	for i, t in ipairs(tabs) do
		if t.tab_id == tab.tab_id then
			tab_idx = i
			break
		end
	end
	local is_last = tab_idx == #tabs
	local next_tab = tabs[tab_idx + 1]
	local next_is_active = next_tab and next_tab.is_active
	local arrow = (tab.is_active or is_last or next_is_active) and tabs_M.arrow_solid or tabs_M.arrow_thin
	local arrow_bg = inactive_bg
	local arrow_fg = colors.tab_bar.inactive_tab_edge

	if is_last then
		arrow_fg = tab.is_active and active_bg or inactive_bg
		arrow_bg = colors.tab_bar.background
	elseif tab.is_active then
		arrow_bg = inactive_bg
		arrow_fg = active_bg
	elseif next_is_active then
		arrow_bg = active_bg
		arrow_fg = inactive_bg
	end

	local ret = tab.is_active
			and {
				{ Attribute = { Intensity = "Bold" } },
				{ Attribute = { Italic = true } },
			}
		or {}
	ret[#ret + 1] = { Text = title }
	ret[#ret + 1] = { Foreground = { Color = arrow_fg } }
	ret[#ret + 1] = { Background = { Color = arrow_bg } }
	ret[#ret + 1] = { Text = arrow }
	return ret
end)

--
-- Keys
--
local keys_M = {}
local act = wezterm.action
keys_M.mod = "SHIFT|SUPER"

keys_M.smart_split = wezterm.action_callback(function(window, pane)
	local dim = pane:get_dimensions()
	if dim.pixel_height > dim.pixel_width then
		window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	end
end)

function keys_M.is_nvim(pane)
	return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim")
end

---@param resize_or_move "resize" | "move"
---@param mods string
---@param key string
---@param dir "Right" | "Left" | "Up" | "Down"
function keys_M.split_nav(resize_or_move, mods, key, dir)
	local event = "SplitNav_" .. resize_or_move .. "_" .. dir
	wezterm.on(event, function(win, pane)
		if keys_M.is_nvim(pane) then
			-- pass the keys through to vim/nvim
			win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
		else
			if resize_or_move == "resize" then
				win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
			else
				win:perform_action({ ActivatePaneDirection = dir }, pane)
			end
		end
	end)
	return {
		key = key,
		mods = mods,
		action = wezterm.action.EmitEvent(event),
	}
end

config.disable_default_key_bindings = true
config.keys = {
	-- Scrollback
	{ mods = keys_M.mod, key = "k", action = act.ScrollByPage(-0.5) },
	{ mods = keys_M.mod, key = "j", action = act.ScrollByPage(0.5) },
	-- New Tab
	{ mods = keys_M.mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
	-- Splits
	{ mods = keys_M.mod, key = "Enter", action = keys_M.smart_split },
	{ mods = keys_M.mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = keys_M.mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Move Tabs
	{ mods = keys_M.mod, key = ">", action = act.MoveTabRelative(1) },
	{ mods = keys_M.mod, key = "<", action = act.MoveTabRelative(-1) },
	-- Acivate Tabs
	{ mods = keys_M.mod, key = "l", action = act({ ActivateTabRelative = 1 }) },
	{ mods = keys_M.mod, key = "h", action = act({ ActivateTabRelative = -1 }) },
	{ mods = keys_M.mod, key = "R", action = wezterm.action.RotatePanes("Clockwise") },
	-- show the pane selection mode, but have it swap the active and selected panes
	{ mods = keys_M.mod, key = "S", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
	-- Clipboard
	{ mods = keys_M.mod, key = "C", action = act.CopyTo("Clipboard") },
	{ mods = keys_M.mod, key = "Space", action = act.QuickSelect },
	{ mods = keys_M.mod, key = "X", action = act.ActivateCopyMode },
	{ mods = keys_M.mod, key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
	{ mods = "SUPER", key = "v", action = act.PasteFrom("Clipboard") },
	{ mods = keys_M.mod, key = "M", action = act.TogglePaneZoomState },
	{ mods = keys_M.mod, key = "p", action = act.ActivateCommandPalette },
	{ mods = keys_M.mod, key = "d", action = act.ShowDebugOverlay },
	{ mods = keys_M.mod, key = "w", action = act.CloseCurrentTab({ confirm = true }) },
	-- Zellij keybindings (Cmd -> Alt+Fkey mapping)
	{ mods = "SUPER", key = "f", action = act.SendKey({ mods = "ALT", key = "F12" }) }, -- Toggle floating panes
	{ mods = "SUPER", key = "d", action = act.SendKey({ mods = "ALT", key = "F11" }) }, -- Next tab
	{
		mods = "SUPER",
		key = "q",
		action = act.Multiple({
			act.SendKey({ mods = "CTRL", key = "q" }),
			act.SendKey({ key = "y" }),
		}),
	}, -- Quit zellij and confirm
	-- Resize
	{ mods = "SUPER", key = "-", action = act.DecreaseFontSize },
	{ mods = "SUPER", key = "+", action = act.IncreaseFontSize },
	{
		mods = keys_M.mod,
		key = "b",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
				"LMSDEV-\\d+",
			},
			action = wezterm.action_callback(function(window, pane)
				local selection = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. selection)

				-- Determine whether the selection is a URL or a JIRA issue
				if string.match(selection, "^https?://") then
					wezterm.open_with(selection) -- Open URL
				else
					local jiraUrl = "https://jira.skillbox.pro/browse/" .. selection
					wezterm.open_with(jiraUrl) -- Open JIRA issue
				end
			end),
		}),
	},
	{
		mods = keys_M.mod,
		key = "j",
		action = wezterm.action.QuickSelectArgs({
			label = "copy jira issue",
			patterns = { "LMSDEV-\\d+" },
			action = wezterm.action_callback(function(window, pane)
				local selection = window:get_selection_text_for_pane(pane)
				window:copy_to_clipboard(selection, "Clipboard")
			end),
		}),
	},
	-- keys_M.split_nav("resize", "CTRL", "LeftArrow", "Right"),
	-- keys_M.split_nav("resize", "CTRL", "RightArrow", "Left"),
	-- keys_M.split_nav("resize", "CTRL", "UpArrow", "Up"),
	-- keys_M.split_nav("resize", "CTRL", "DownArrow", "Down"),
	-- keys_M.split_nav("move", "CTRL", "h", "Left"),
	-- keys_M.split_nav("move", "CTRL", "j", "Down"),
	-- keys_M.split_nav("move", "CTRL", "k", "Up"),
	-- keys_M.split_nav("move", "CTRL", "l", "Right"),
}

config.default_prog = { "/opt/homebrew/bin/fish" }
config.default_cwd = wezterm.home_dir

-- config.color_scheme = "Tokyo Night Moon"
config.color_scheme = "Catppuccin Latte"

config.hyperlink_rules = {
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},
	{
		regex = [[\b[A-Z]+-\d+\b]],
		format = "https://jira.skillbox.pro/browse/$0",
	},
}

config.max_fps = 120

return config

-- return {
-- 	audible_bell = "Disabled",
-- 	canonicalize_pasted_newlines = "LineFeed",
-- 	cursor_blink_rate = 500,
-- 	cursor_thickness = 1.5,
-- 	default_cursor_style = "BlinkingBar",
-- 	default_cwd = wezterm.home_dir,
-- 	default_prog = { "/usr/local/bin/fish" },
-- 	font = wezterm.font("JetBrains Mono"),
-- 	initial_cols = 120,
-- 	initial_rows = 37,
-- 	window_frame = {
-- 		-- The font used in the tab bar.
-- 		-- Roboto Bold is the default; this font is bundled
-- 		-- with wezterm.
-- 		-- Whatever font is selected here, it will have the
-- 		-- main font setting appended to it to pick up any
-- 		-- fallback fonts you may have used there.
-- 		font = font({ family = "FiraCode Nerd Font", weight = "Bold" }),
--
-- 		-- The size of the font in the tab bar.
-- 		-- Default to 10. on Windows but 12.0 on other systems
-- 		font_size = 11.0,
--
-- 		-- The overall background color of the tab bar when
-- 		-- the window is focused
-- 		active_titlebar_bg = "#191b28",
--
-- 		-- The overall background color of the tab bar when
-- 		-- the window is not focused
-- 		inactive_titlebar_bg = "#1e2030",
-- 	},
-- 	window_padding = {
-- 		left = 0,
-- 		right = 0,
-- 		top = 0,
-- 		bottom = 0,
-- 	},
-- 	colors = {
-- 		tab_bar = {
-- 			-- The color of the inactive tab bar edge/divider
-- 			inactive_tab_edge = "#1e2030",
-- 			background = "#191b28",
-- 			active_tab = {
-- 				fg_color = "#82aaff",
-- 				bg_color = "#222436",
-- 			},
-- 			inactive_tab = {
-- 				bg_color = "#1e2030",
-- 				fg_color = "#545c7e",
-- 			},
-- 			inactive_tab_hover = {
-- 				bg_color = "#1e2030",
-- 				fg_color = "#82aaff",
-- 			},
-- 			new_tab_hover = {
-- 				fg_color = "#1e2030",
-- 				bg_color = "#82aaff",
-- 			},
-- 			new_tab = {
-- 				fg_color = "#82aaff",
-- 				bg_color = "#191b28",
-- 			},
-- 		},
-- 	},
-- 	color_scheme = "Catppuccin Latte",
-- 	font_size = 13.0,
-- 	use_fancy_tab_bar = true,
-- 	tab_bar_at_bottom = true,
-- 	hide_tab_bar_if_only_one_tab = true,
-- 	show_tab_index_in_tab_bar = false,
-- 	hyperlink_rules = {
-- 		-- Linkify things that look like URLs and the host has a TLD name.
-- 		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
-- 		{
-- 			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
-- 			format = "$0",
-- 		},
-- 		-- linkify email addresses
-- 		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
-- 		{
-- 			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
-- 			format = "mailto:$0",
-- 		},
-- 		-- Make JIRA task numbers clickable
-- 		-- The first matched regex group is captured in $1.
-- 		{
-- 			regex = [[\b((LMSDEV|DEVOPS|ARCH|WEBDEV)-\d+)\b]],
-- 			format = "https://jira.skillbox.pro/browse/$1",
-- 		},
-- 		-- Linkify things that look like URLs with numeric addresses as hosts.
-- 		-- E.g. http://127.0.0.1:8000 for a local development server,
-- 		-- or http://192.168.1.1 for the web interface of many routers.
-- 		{
-- 			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
-- 			format = "$0",
-- 		},
-- 	},
-- 	disable_default_key_bindings = true,
-- 	keys = {
-- 		{ mods = mod, key = "UpArrow", action = act.ActivatePaneDirection("Up") },
-- 		{ mods = mod, key = "DownArrow", action = act.ActivatePaneDirection("Down") },
-- 		{ mods = mod, key = "RightArrow", action = act.ActivatePaneDirection("Right") },
-- 		{ mods = mod, key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
-- 		{ mods = "SUPER", key = "k", action = act.ActivatePaneDirection("Up") },
-- 		{ mods = "SUPER", key = "j", action = act.ActivatePaneDirection("Down") },
-- 		{ mods = "SUPER", key = "l", action = act.ActivatePaneDirection("Right") },
-- 		{ mods = "SUPER", key = "h", action = act.ActivatePaneDirection("Left") },
-- 		{ mods = "SUPER", key = "t", action = act.SpawnTab("CurrentPaneDomain") },
-- 		{ mods = mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
-- 		{ mods = mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
-- 		{ mods = mod, key = ">", action = act.MoveTabRelative(1) },
-- 		{ mods = mod, key = "<", action = act.MoveTabRelative(-1) },
-- 		{ mods = mod, key = "M", action = act.TogglePaneZoomState },
-- 		{ mods = mod, key = "p", action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
-- 		{ mods = mod, key = "C", action = act.CopyTo("ClipboardAndPrimarySelection") },
-- 		{ mods = mod, key = "l", action = wezterm.action({ ActivateTabRelative = 1 }) },
-- 		{ mods = mod, key = "h", action = wezterm.action({ ActivateTabRelative = -1 }) },
-- 		{ key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
-- 		{ mods = "SUPER", key = "-", action = act.DecreaseFontSize },
-- 		{ mods = "SUPER", key = "+", action = act.IncreaseFontSize },
-- 		{ mods = "CTRL", key = "x", action = act.ActivateCopyMode },
-- 		{ mods = mod, key = "s", action = act.ShowTabNavigator },
-- 		{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("PrimarySelection") },
-- 		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
-- 	},
-- 	use_dead_keys = false,
-- 	key_tables = {
-- 		copy_mode = {
-- 			{
-- 				key = "e",
-- 				mods = "NONE",
-- 				action = act.CopyMode("MoveForwardWordEnd"),
-- 			},
-- 		},
-- 	},
-- 	max_fps = 120,
-- 	tab_max_width = 60,
-- 	bold_brightens_ansi_colors = true,
-- 	window_background_opacity = 0.95,
-- 	cell_width = 0.9,
-- 	scrollback_lines = 10000,
-- }

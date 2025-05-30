local wezterm = require("wezterm")
local util = require("wezbar.util")

local M = {}

local default_opts = {
	options = {
		theme = wezterm.colors or "Catppuccin Mocha",
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		wezbar_a = { "mode", { Attribute = { Intensity = "Bold" } } },
		wezbar_b = { "workspace" },
		wezbar_c = { "hostname" },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		wezbar_x = { "cpu", "ram" },
		wezbar_y = { "battery" },
		wezbar_z = { "datetime" },
	},
	extensions = {},
}

local default_component_opts = {
	icons_enabled = true,
	icons_only = false,
	padding = 2,
}

local function get_colors(theme)
	local colors = type(theme) ~= "string" and theme or wezterm.color.get_builtin_schemes()[theme]
	local surface = colors.tab_bar and colors.tab_bar.inactive_tab_edge or colors.background

	return {
		normal_mode = {
			a = { fg = colors.background, bg = colors.ansi[5] },
			b = { fg = colors.ansi[5], bg = surface },
			c = { fg = colors.ansi[5], bg = surface },
			x = { fg = colors.ansi[18], bg = surface },
			y = { fg = colors.ansi[17], bg = surface },
			z = { fg = colors.ansi[5], bg = surface },
		},
		leader_mode = {
			a = { fg = colors.background, bg = colors.ansi[2] },
			b = { fg = colors.ansi[5], bg = surface },
			c = { fg = colors.ansi[5], bg = surface },
			x = { fg = colors.ansi[18], bg = surface },
			y = { fg = colors.ansi[17], bg = surface },
			z = { fg = colors.ansi[5], bg = surface },
		},
		copy_mode = {
			a = { fg = colors.background, bg = colors.ansi[6] },
			b = { fg = colors.ansi[5], bg = surface },
			c = { fg = colors.ansi[5], bg = surface },
			x = { fg = colors.ansi[18], bg = surface },
			y = { fg = colors.ansi[17], bg = surface },
			z = { fg = colors.ansi[5], bg = surface },
		},
		search_mode = {
			a = { fg = colors.background, bg = colors.ansi[4] },
			b = { fg = colors.ansi[5], bg = surface },
			c = { fg = colors.ansi[5], bg = surface },
			x = { fg = colors.ansi[18], bg = surface },
			y = { fg = colors.ansi[17], bg = surface },
			z = { fg = colors.ansi[5], bg = surface },
		},
		tab = {
			active = { fg = colors.tab_bar.active_tab.fg_color, bg = colors.tab_bar.active_tab.bg_color },
			inactive = { fg = colors.tab_bar.inactive_tab.fg_color, bg = colors.tab_bar.inactive_tab.bg_color },
			inactive_hover = {
				fg = colors.tab_bar.inactive_tab_hover.fg_color,
				bg = colors.tab_bar.inactive_tab_hover.bg_color,
			},
		},
		colors = colors,
	}
end

local function set_component_opts(user_opts)
	local component_opts = {}

	for key, default_value in pairs(default_component_opts) do
		component_opts[key] = default_value
		if user_opts.options[key] ~= nil then
			component_opts[key] = user_opts.options[key]
			user_opts.options[key] = nil
		end
	end

	return component_opts
end

function M.set(user_opts)
	user_opts = user_opts or { options = {} }
	user_opts.options = user_opts.options or {}
	local theme_overrides = user_opts.options.theme_overrides or {}
	user_opts.options.theme_overrides = nil

	M.component_opts = set_component_opts(user_opts)
	M.opts = util.deep_extend(default_opts, user_opts)
	M.sections = util.deep_copy(M.opts.sections)
	M.theme = util.deep_extend(get_colors(M.opts.options.theme), theme_overrides)
end

function M.set_theme(theme, overrides)
	if theme == nil and overrides == nil then
		local current_theme = M.opts and M.opts.options.theme or default_opts.options.theme
		M.theme = util.deep_extend(get_colors(current_theme), {})
	elseif type(theme) == "table" then
		M.theme = util.deep_extend(M.theme or {}, theme)
	else
		M.theme = util.deep_extend(get_colors(theme), overrides or {})
	end
end

return M

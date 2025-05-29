local wezterm = require("wezterm")

local M = {}

--- Checks if the user is on windows
local is_windows = string.match(wezterm.target_triple, "windows") ~= nil
local separator = is_windows and "\\" or "/"

local plugin_dir = wezterm.plugin.list()[1].plugin_dir:gsub(separator .. "[^" .. separator .. "]*$", "")

--- Checks if the plugin directory exists
local function directory_exists(path)
	local success, result = pcall(wezterm.read_dir, plugin_dir .. path)
	return success and result
end

--- Returns the name of the package, used when requiring modules
local function get_require_path()
	-- HTTPS version
	local https_path = "httpssCssZssZsgithubsDscomsZstsdevausZswezbar"
	local https_path_slash = "httpssCssZssZsgithubsDscomsZstsdevausZswezbarsZs"
	-- HTTP version
	local http_path = "httpCssZssZsgithubsDscomsZstsdevausZswezbar"
	local http_path_slash = "httpCssZssZsgithubsDscomsZstsdevausZswezbarsZs"
	-- Check all possible paths
	if directory_exists(https_path_slash) then
		return https_path_slash
	end
	if directory_exists(https_path) then
		return https_path
	end
	if directory_exists(http_path_slash) then
		return http_path_slash
	end
	if directory_exists(http_path) then
		return http_path
	end

	-- Default fallback
	return https_path
end

package.path = package.path
	.. ";"
	.. plugin_dir
	.. separator
	.. get_require_path()
	.. separator
	.. "plugin"
	.. separator
	.. "?.lua"

function M.setup(opts)
	require("wezbar.config").set(opts)

	wezterm.on("update-status", function(window)
		require("wezbar.component").set_status(window)
	end)

	wezterm.on("format-tab-title", function(tab, _, _, _, hover, _)
		return require("wezbar.tabs").set_title(tab, hover)
	end)

	require("wezbar.extension").load()
end

function M.apply_to_config(config)
	config.use_fancy_tab_bar = true
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 32
	config.window_decorations = "RESIZE"
	config.window_padding = config.window_padding or {}
	config.colors = config.colors or {}
	config.colors.tab_bar = config.colors.tab_bar or {}
	config.status_update_interval = 500
end

function M.get_config()
	return require("wezbar.config").opts
end

function M.get_theme()
	return require("wezbar.config").theme
end

function M.set_theme(theme, overrides)
	return require("wezbar.config").set_theme(theme, overrides)
end

function M.refresh(window, tab)
	if window then
		require("wezbar.component").set_status(window)
	end
	if tab then
		require("wezbar.tabs").set_title(tab)
	end
end

return M

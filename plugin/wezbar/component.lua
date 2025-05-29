local wezterm = require("wezterm")
local util = require("wezbar.util")
local config = require("wezbar.config")
local extension = require("wezbar.extension")
local mode = require("wezbar.components.window.mode")

local M = {}

local left_section_separator =
	{ Text = config.opts.options.section_separators.left or config.opts.options.section_separators }
local right_section_separator =
	{ Text = config.opts.options.section_separators.right or config.opts.options.section_separators }
local left_component_separator =
	{ Text = config.opts.options.component_separators.left or config.opts.options.component_separators }
local right_component_separator =
	{ Text = config.opts.options.component_separators.right or config.opts.options.component_separators }

local attributes_a, attributes_b, attributes_c, attributes_x, attributes_y, attributes_z = {}, {}, {}, {}, {}, {}
local section_separator_attributes_a, section_separator_attributes_b, section_separator_attributes_c, section_separator_attributes_x, section_separator_attributes_y, section_separator_attributes_z =
	{}, {}, {}, {}, {}, {}
local wezbar_a, wezbar_b, wezbar_c, wezbar_x, wezbar_y, wezbar_z = {}, {}, {}, {}, {}, {}

local function create_attributes(window)
	local current_mode = mode.get(window)
	local colors = config.theme[current_mode]
	for _, ext in pairs(extension.extensions) do
		if ext.theme then
			colors = util.deep_extend(util.deep_copy(colors), ext.theme)
		end
	end
	attributes_a = {
		{ Foreground = { Color = colors.a.fg } },
		{ Background = { Color = colors.a.bg } },
		{ Attribute = { Intensity = "Bold" } },
	}
	attributes_b = {
		{ Foreground = { Color = colors.b.fg } },
		{ Background = { Color = colors.b.bg } },
		{ Attribute = { Intensity = "Normal" } },
	}
	attributes_c = {
		{ Foreground = { Color = colors.c.fg } },
		{ Background = { Color = colors.c.bg } },
	}
	attributes_x = {
		{ Foreground = { Color = colors.x and colors.x.fg or colors.c.fg } },
		{ Background = { Color = colors.x and colors.x.bg or colors.c.bg } },
	}
	attributes_y = {
		{ Foreground = { Color = colors.y and colors.y.fg or colors.b.fg } },
		{ Background = { Color = colors.y and colors.y.bg or colors.b.bg } },
		{ Attribute = { Intensity = "Normal" } },
	}
	attributes_z = {
		{ Foreground = { Color = colors.z and colors.z.fg or colors.a.fg } },
		{ Background = { Color = colors.z and colors.z.bg or colors.a.bg } },
		{ Attribute = { Intensity = "Bold" } },
	}
	section_separator_attributes_a = {
		{ Foreground = { Color = colors.a.bg } },
		{ Background = { Color = colors.b.bg } },
	}
	section_separator_attributes_b = {
		{ Foreground = { Color = colors.b.bg } },
		{ Background = { Color = colors.c.bg } },
	}
	section_separator_attributes_c = {
		{ Foreground = { Color = colors.a.bg } },
		{ Background = { Color = colors.c.bg } },
	}
	section_separator_attributes_x = {
		{ Foreground = { Color = colors.z and colors.z.bg or colors.a.bg } },
		{ Background = { Color = colors.x and colors.x.bg or colors.c.bg } },
	}
	section_separator_attributes_y = {
		{ Foreground = { Color = colors.y and colors.y.bg or colors.b.bg } },
		{ Background = { Color = colors.x and colors.x.bg or colors.c.bg } },
	}
	section_separator_attributes_z = {
		{ Foreground = { Color = colors.z and colors.z.bg or colors.a.bg } },
		{ Background = { Color = colors.y and colors.y.bg or colors.b.bg } },
	}
end

local function insert_component_separators(components, is_left)
	local i = 1
	while i <= #components do
		if type(components[i]) == "table" and components[i].Text and i < #components then
			table.insert(components, i + 1, is_left and left_component_separator or right_component_separator)
			i = i + 1
		end
		i = i + 1
	end
	return components
end

local function create_sections(window)
	local sections = config.sections
	for _, ext in pairs(extension.extensions) do
		if ext.sections then
			sections = util.deep_extend(util.deep_copy(sections), ext.sections)
		end
	end
	wezbar_a = insert_component_separators(util.extract_components(sections.wezbar_a, attributes_a, window, true), true)
	wezbar_b = insert_component_separators(util.extract_components(sections.wezbar_b, attributes_b, window, true), true)
	wezbar_c = insert_component_separators(util.extract_components(sections.wezbar_c, attributes_c, window, true), true)
	wezbar_x =
		insert_component_separators(util.extract_components(sections.wezbar_x, attributes_x, window, true), false)
	wezbar_y =
		insert_component_separators(util.extract_components(sections.wezbar_y, attributes_y, window, true), false)
	wezbar_z =
		insert_component_separators(util.extract_components(sections.wezbar_z, attributes_z, window, true), false)
end

local function right_section()
	local result = {}
	if #wezbar_x > 0 then
		util.insert_elements(result, attributes_x)
		util.insert_elements(result, wezbar_x)
	end
	if #wezbar_y > 0 then
		util.insert_elements(result, section_separator_attributes_y)
		table.insert(result, right_section_separator)
	end
	if #wezbar_y > 0 then
		util.insert_elements(result, attributes_y)
		util.insert_elements(result, wezbar_y)
	end
	if #wezbar_z > 0 and #wezbar_y > 0 then
		util.insert_elements(result, section_separator_attributes_z)
		table.insert(result, right_section_separator)
	elseif #wezbar_z > 0 then
		util.insert_elements(result, section_separator_attributes_x)
		table.insert(result, right_section_separator)
	end
	if #wezbar_z > 0 then
		util.insert_elements(result, attributes_z)
		util.insert_elements(result, wezbar_z)
	end
	return result
end

local function left_section()
	local result = {}
	if #wezbar_a > 0 then
		util.insert_elements(result, attributes_a)
		util.insert_elements(result, wezbar_a)
	end
	if #wezbar_a > 0 and #wezbar_b > 0 then
		util.insert_elements(result, section_separator_attributes_a)
		table.insert(result, left_section_separator)
	elseif #wezbar_a > 0 then
		util.insert_elements(result, section_separator_attributes_c)
		table.insert(result, left_section_separator)
	end
	if #wezbar_b > 0 then
		util.insert_elements(result, attributes_b)
		util.insert_elements(result, wezbar_b)
	end
	if #wezbar_b > 0 then
		util.insert_elements(result, section_separator_attributes_b)
		table.insert(result, left_section_separator)
	end
	if #wezbar_c > 0 then
		util.insert_elements(result, attributes_c)
		util.insert_elements(result, wezbar_c)
	end
	return result
end

function M.set_status(window)
	create_attributes(window)
	create_sections(window)
	window:set_left_status(wezterm.format(left_section()))
	window:set_right_status(wezterm.format(right_section()))
end

return M

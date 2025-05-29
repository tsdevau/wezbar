local wezterm = require("wezterm")
local util = require("wezbar.util")
local config = require("wezbar.config")
local colors = config.theme.colors

return {
	default_opts = {
		battery_to_icon = {
			batt_98_charging = { wezterm.nerdfonts.md_battery_charging, color = { fg = colors.ansi[2] } },
			batt_98 = { wezterm.nerdfonts.md_battery, color = { fg = colors.ansi[2] } },
			batt_90_charging = { wezterm.nerdfonts.md_battery_charging_90, color = { fg = colors.ansi[2] } },
			batt_90 = { wezterm.nerdfonts.md_battery_90, color = { fg = colors.ansi[3] } },
			batt_80_charging = { wezterm.nerdfonts.md_battery_charging_80, color = { fg = colors.ansi[2] } },
			batt_80 = { wezterm.nerdfonts.md_battery_80, color = { fg = colors.ansi[3] } },
			batt_70_charging = { wezterm.nerdfonts.md_battery_charging_70, color = { fg = colors.ansi[2] } },
			batt_70 = { wezterm.nerdfonts.md_battery_70, color = { fg = colors.ansi[3] } },
			batt_60_charging = { wezterm.nerdfonts.md_battery_charging_60, color = { fg = colors.ansi[2] } },
			batt_60 = { wezterm.nerdfonts.md_battery_60, color = { fg = colors.ansi[3] } },
			batt_50_charging = { wezterm.nerdfonts.md_battery_charging_50, color = { fg = colors.ansi[2] } },
			batt_50 = { wezterm.nerdfonts.md_battery_50, color = { fg = colors.ansi[3] } },
			batt_40_charging = { wezterm.nerdfonts.md_battery_charging_40, color = { fg = colors.ansi[2] } },
			batt_40 = { wezterm.nerdfonts.md_battery_40, color = { fg = colors.ansi[3] } },
			batt_30_charging = { wezterm.nerdfonts.md_battery_charging_30, color = { fg = colors.ansi[2] } },
			batt_30 = { wezterm.nerdfonts.md_battery_30, color = { fg = colors.ansi[3] } },
			batt_20_charging = { wezterm.nerdfonts.md_battery_charging_20, color = { fg = colors.ansi[3] } },
			batt_20 = { wezterm.nerdfonts.md_battery_20, color = { fg = colors.ansi[4] } },
			batt_10_charging = { wezterm.nerdfonts.md_battery_charging_10, color = { fg = colors.ansi[4] } },
			batt_10 = { wezterm.nerdfonts.md_battery_10, color = { fg = colors.ansi[4] } },
			batt_empty_charging = { wezterm.nerdfonts.md_battery_charging_outline, color = { fg = colors.ansi[4] } },
			batt_empty = { wezterm.nerdfonts.md_battery_alert_variant_outline, color = { fg = colors.ansi[4] } },
		},
	},

	update = function(_, opts)
		local batt_string = ""
		for _, b in ipairs(wezterm.battery_info()) do
			local level = b.state_of_charge * 100
			local is_charging = b.state == "Charging"
			batt_string = string.format("%.0f%%", level)
			if opts.icons_enabled and opts.battery_to_icon then
				if is_charging then
					if level >= 98 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_98_charging)
					elseif level >= 90 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_90_charging)
					elseif level >= 80 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_80_charging)
					elseif level >= 70 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_70_charging)
					elseif level >= 60 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_60_charging)
					elseif level >= 50 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_50_charging)
					elseif level >= 40 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_40_charging)
					elseif level >= 30 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_30_charging)
					elseif level >= 20 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_20_charging)
					elseif level >= 10 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_10_charging)
					else
						util.overwrite_icon(opts, opts.battery_to_icon.batt_empty_charging)
					end
				else
					if level >= 98 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_98)
					elseif level >= 90 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_90)
					elseif level >= 80 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_80)
					elseif level >= 70 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_70)
					elseif level >= 60 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_60)
					elseif level >= 50 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_50)
					elseif level >= 40 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_40)
					elseif level >= 30 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_30)
					elseif level >= 20 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_20)
					elseif level >= 10 then
						util.overwrite_icon(opts, opts.battery_to_icon.batt_10)
					else
						util.overwrite_icon(opts, opts.battery_to_icon.batt_empty)
					end
				end
			end
			return batt_string
		end
	end,
}

local wezterm = require("wezterm")
local util = require("wezbar.util")

return {
  default_opts = {
    style = "%a %d %b %Y %H:%M",
    hour_to_icon = {
      ["00"] = wezterm.nerdfonts.md_clock_time_twelve_outline,
      ["01"] = wezterm.nerdfonts.md_clock_time_one_outline,
      ["02"] = wezterm.nerdfonts.md_clock_time_two_outline,
      ["03"] = wezterm.nerdfonts.md_clock_time_three_outline,
      ["04"] = wezterm.nerdfonts.md_clock_time_four_outline,
      ["05"] = wezterm.nerdfonts.md_clock_time_five_outline,
      ["06"] = wezterm.nerdfonts.md_clock_time_six_outline,
      ["07"] = wezterm.nerdfonts.md_clock_time_seven_outline,
      ["08"] = wezterm.nerdfonts.md_clock_time_eight_outline,
      ["09"] = wezterm.nerdfonts.md_clock_time_nine_outline,
      ["10"] = wezterm.nerdfonts.md_clock_time_ten_outline,
      ["11"] = wezterm.nerdfonts.md_clock_time_eleven_outline,
      ["12"] = wezterm.nerdfonts.md_clock_time_twelve_outline,
      ["13"] = wezterm.nerdfonts.md_clock_time_one_outline,
      ["14"] = wezterm.nerdfonts.md_clock_time_two_outline,
      ["15"] = wezterm.nerdfonts.md_clock_time_three_outline,
      ["16"] = wezterm.nerdfonts.md_clock_time_four_outline,
      ["17"] = wezterm.nerdfonts.md_clock_time_five_outline,
      ["18"] = wezterm.nerdfonts.md_clock_time_six_outline,
      ["19"] = wezterm.nerdfonts.md_clock_time_seven_outline,
      ["20"] = wezterm.nerdfonts.md_clock_time_eight_outline,
      ["21"] = wezterm.nerdfonts.md_clock_time_nine_outline,
      ["22"] = wezterm.nerdfonts.md_clock_time_ten_outline,
      ["23"] = wezterm.nerdfonts.md_clock_time_eleven_outline,
    },
  },
  update = function(_, opts)
    local datetime = wezterm.strftime(opts.style)

    if opts.icons_enabled and opts.hour_to_icon then
      local hour = wezterm.strftime("%H")
      util.overwrite_icon(opts, opts.hour_to_icon[hour])
    end

    return datetime
  end,
}

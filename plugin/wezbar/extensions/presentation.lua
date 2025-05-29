local wezterm = require("wezterm")
local config = require("wezbar.config")

return {
  {
    "presentation",
    events = {
      show = "xarvex.presentation.activate",
      hide = "xarvex.presentation.deactivate",
    },
    sections = {
      wezbar_a = {
        " " .. wezterm.nerdfonts.md_presentation_play .. " Presenting ",
      },
      wezbar_b = { "workspace" },

      -- Clear for a focused presentation.
      wezbar_c = {},
      wezbar_x = {},
      wezbar_y = {},
      wezbar_z = { "datetime" },
      tab_active = {},
      tab_inactive = {},
    },
    theme = {
      a = { bg = config.theme.colors.ansi[7] },
      b = { fg = config.theme.colors.ansi[7] },
    },
  },
}

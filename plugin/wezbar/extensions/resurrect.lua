local wezterm = require("wezterm")
local config = require("wezbar.config")

return {
  {
    "resurrect",
    events = {
      show = "resurrect.fuzzy_loader.fuzzy_load.start",
      hide = {
        "resurrect.fuzzy_loader.fuzzy_load.finished",
        "quick_domain.fuzzy_selector.opened",
        "smart_workspace_switcher.workspace_switcher.start",
      },
    },
    sections = {
      wezbar_a = {
        " " .. wezterm.nerdfonts.md_sleep_off .. " Resurrect ",
      },
      wezbar_b = { "workspace" },
      wezbar_c = { "window" },
      tab_active = {},
      tab_inactive = {},
    },
    theme = {
      a = { bg = config.theme.colors.ansi[3] },
      b = { fg = config.theme.colors.ansi[3] },
    },
  },
  {
    "resurrect.state_manager.periodic_save",
    events = {
      show = "resurrect.state_manager.periodic_save",
      delay = 7,
    },
    sections = {
      wezbar_x = {
        { Foreground = { Color = config.theme.colors.brights[4] } },
        wezterm.nerdfonts.cod_save .. " saved workspace ",
      },
    },
  },
}

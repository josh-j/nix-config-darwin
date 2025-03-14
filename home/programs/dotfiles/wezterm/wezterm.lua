local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function is_found(str, pattern)
  return string.find(str, pattern) ~= nil
end

local function platform()
  return {
    is_win = is_found(wezterm.target_triple, "windows"),
    is_linux = is_found(wezterm.target_triple, "linux"),
    is_mac = is_found(wezterm.target_triple, "apple"),
  }
end

if platform().is_mac then
  -- config.default_prog = {"tmux", "attach", "||", "tmux"}
  config.font_size = 13
  config.window_background_opacity = 0.90
  config.macos_window_background_blur = 30
  config.front_end = "WebGpu"
  config.webgpu_power_preference = "LowPower"
elseif platform().is_win then
  config.front_end = "opengl"
  config.font_size = 9
  config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-l" }
end

config.max_fps = 30
config.animation_fps = 10
config.enable_wayland = false
config.window_close_confirmation = "NeverPrompt"

-- config.color_scheme = "Whimsy"
-- config.color_scheme = "oxocarbon"
-- config.color_scheme = "BlueBerryPie"
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "PaperColor Dark (base16)"
-- config.color_scheme = "Wryan"
-- config.color_scheme = "Papercolor Dark (Gogh)"
-- config.color_scheme = "Pencil Dark (Gogh)"
-- config.color_scheme = "Oxocarbon Dark (Gogh)"
config.color_schemes = {
  ['sio-rose'] = {
    background = "#2a282a",
    foreground = "#FFF1E8",
    cursor_bg = "#57526B",
    cursor_fg = "#57526B",
    cursor_border = "#57526B",
    selection_bg = "#3A374D",
    selection_fg = "#FFF1E8",
    ansi = {
      "#504A73",  -- black
      "#BA506E",  -- red
      "#3D87A4",  -- green
      "#BA9C73",  -- yellow
      "#618f97",  -- blue
      "#9476B7",  -- magenta
      "#605d84",  -- cyan
      "#D3D1E6",  -- white
    },
    brights = {
      "#8783A3",  -- bright black
      "#A3A1B1",  -- bright red
      "#50B8E3",  -- bright green
      "#F6D499",  -- bright yellow
      "#9CCFD8",  -- bright blue
      "#C4A7E7",  -- bright magenta
      "#C5C0FF",  -- bright cyan
      "#EAE8FF",  -- bright white
    },
  }
}

config.color_scheme = 'sio-rose'

config.font = wezterm.font_with_fallback({
  {
    family = "JetBrainsMono Nerd Font",
    weight = 500,
  },
  {
    family = "Cascadia Code",
    weight = 500,
  },
  {
    family = "JetBrainsMono NF",
    weight = 500,
  },
  {
    family = "SF Mono",
    weight = 500,
  },
  {
    family = "Courier",
  },
})

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.status_update_interval = 1000
config.window_decorations = "RESIZE"
config.scrollback_lines = 10000
config.default_workspace = "home"
config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
-- config.disable_default_key_bindings = true
config.enable_scroll_bar = false
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.9,
}

config.window_padding = {
  left = 5,
  right = 0,
  top = 5,
  bottom = 5,
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Pane navigation
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Pane creation
  { key = 'H', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'J', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'K', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'L', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  { key = 'LeftArrow', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'DownArrow', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'UpArrow', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'RightArrow', mods = 'LEADER|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  { key = 's', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Right' } },
  -- Resize panes
  { key = '-', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = '=', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = '[', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = ']', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },

  -- Window management
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  { key = 'n', mods = 'LEADER', action = wezterm.action.SpawnWindow },
  { key = 'q', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = '\'', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS'},
  },

  -- Configuration
  { key = '\\', mods = 'LEADER', action = wezterm.action.ShowDebugOverlay },
  { key = ';', mods = 'LEADER', action = wezterm.action.ShowLauncher },
  { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration },
}

-- Additional global keybinds
config.key_tables = {
  quick_terminal = {
    { key = '`', mods = 'CTRL', action = wezterm.action_callback(function(window, pane)
        window:perform_action(wezterm.action.TogglePaneZoomState, pane)
      end) },
  }
}

return config

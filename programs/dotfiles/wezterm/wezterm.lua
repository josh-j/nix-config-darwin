-- Taken from nix-darwin dotfiles
-- Pull in the wezterm API
-- https://github.com/KevinSilvester/wezterm-config/
local act = wezterm.action
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

local function is_found(str, pattern)
    return string.find(str, pattern) ~= nil
end

local function platform()
    return {
        is_win = is_found(wezterm.target_triple, "windows"),
        is_linux = is_found(wezterm.target_triple, "linux"),
        is_mac = is_found(wezterm.target_triple, "apple")
    }
end

if platform().is_mac then
    -- config.default_prog = {"tmux", "attach", "||", "tmux"}

    config.font_size = 13
    config.window_background_opacity = 0.85
    config.macos_window_background_blur = 30
elseif platform().is_win then
    config.font_size = 9
    config.default_prog = {"C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-l"}
end

config.front_end = "WebGpu"
config.window_close_confirmation = "NeverPrompt"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Whimsy"
-- config.color_scheme = "oxocarbon"
-- config.color_scheme = "BlueBerryPie"
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "PaperColor Dark (base16)"
-- config.color_scheme = "Wryan"
-- config.color_scheme = "Papercolor Dark (Gogh)"
-- config.color_scheme = "Pencil Dark (Gogh)"
-- config.color_scheme = "Oxocarbon Dark (Gogh)"
config.font = wezterm.font_with_fallback({{
    family = "JetBrainsMono Nerd Font",
    weight = 500
}, {
    family = "Cascadia Code",
    weight = 500
}, {
    family = "JetBrainsMono NF",
    weight = 500
}, {
    family = "SF Mono",
    weight = 500
}, {
    family = "Courier"
}})

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.status_update_interval = 1000
-- config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_ENABLE_SHADOW"
config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW"
config.scrollback_lines = 10000
config.default_workspace = "home"
config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
-- config.disable_default_key_bindings = true
config.leader = {
    key = "o",
    mods = "CTRL|SHIFT"
}
config.enable_scroll_bar = false
config.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5
}

config.window_padding = {
    left = 5,
    right = 0,
    top = 5,
    bottom = 5
}

config.keys = {{
    key = "l",
    mods = "CTRL|ALT",
    action = wezterm.action.ShowLauncher
}, {
    key = "Home",
    mods = "NONE",
    action = act.SendKey({
        mods = "CTRL",
        key = "a"
    })
}, {
    key = "End",
    mods = "NONE",
    action = act.SendKey({
        mods = "CTRL",
        key = "e"
    })
}}

return config

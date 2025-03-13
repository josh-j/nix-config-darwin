
-- Define the color palette
local palette = {
  "#504A73",  -- 0
  "#BA506E",  -- 1
  "#3D87A4",  -- 2
  "#BA9C73",  -- 3
  "#618f97",  -- 4
  "#9476B7",  -- 5
  "#605d84",  -- 6
  "#D3D1E6",  -- 7
  "#8783A3",  -- 8
  "#A3A1B1",  -- 9
  "#50B8E3",  -- 10
  "#F6D499",  -- 11
  "#9CCFD8",  -- 12
  "#C4A7E7",  -- 13
  "#C5C0FF",  -- 14
  "#EAE8FF",  -- 15
}

-- Define the theme settings
local theme = {
  background = "#282828",
  foreground = "#FFF1E8",
  cursor_color = "#57526B",
  selection_background = "#3A374D",
  selection_foreground = "#FFF1E8",
}

-- WezTerm configuration
return {
  color_scheme = "Custom",
  colors = {
    background = theme.background,
    foreground = theme.foreground,
    cursor_bg = theme.cursor_color,
    cursor_fg = theme.cursor_color,
    cursor_border = theme.cursor_color,
    selection_bg = theme.selection_background,
    selection_fg = theme.selection_foreground,
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
  },
}

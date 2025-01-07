{
  config,
  pkgs,
  ...
}:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "mydracula";
      on_force_close = "detach";
      simplified_ui = false;
      default_shell = "zsh";
      pane_frames = true;
      auto_layout = true;
      default_mode = "normal";
      mouse_mode = true;
      scroll_buffer_size = 10000;
      copy_clipboard = "system";
      copy_on_select = true;
      scrollback_editor = "$EDITOR";
      mirror_session = false;
      ui = {
        pane_frames = {
          hide_session_name = true;
          rounded_corners = true;
        };
      };
      styled_underlines = true;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 500;
      keybinds = {
        "normal clear-defaults=true" = {
          "bind \"Alt F\"" = {
            "LaunchPlugin \"file:~/.config/zellij/plugins/monocle.wasm\"" = {
              in_place = true;
              kiosk = true;
            };
          };
          "bind \"Alt h\"" = {MoveFocus = "Left";};
          "bind \"Alt j\"" = {MoveFocus = "Down";};
          "bind \"Alt k\"" = {MoveFocus = "Up";};
          "bind \"Alt l\"" = {MoveFocus = "Right";};

          "bind \"Alt H\"" = {Resize = "Increase Left";};
          "bind \"Alt J\"" = {Resize = "Increase Down";};
          "bind \"Alt K\"" = {Resize = "Increase Up";};
          "bind \"Alt L\"" = {Resize = "Increase Right";};
          "bind \"Alt +\"" = {Resize = "Increase";};
          "bind \"Alt -\"" = {Resize = "Decrease";};

          "bind \"Alt Left\"" = {MovePane = "Left";};
          "bind \"Alt Down\"" = {MovePane = "Down";};
          "bind \"Alt Up\"" = {MovePane = "Up";};
          "bind \"Alt Right\"" = {MovePane = "Right";};

          "bind \"Alt w\"" = {GoToTab = 1;};
          "bind \"Alt e\"" = {GoToTab = 2;};
          "bind \"Alt r\"" = {GoToTab = 3;};
          "bind \"Alt s\"" = {GoToTab = 4;};
          "bind \"Alt d\"" = {GoToTab = 5;};
          "bind \"Alt f\"" = {GoToTab = 6;};
          "bind \"Alt x\"" = {GoToTab = 7;};
          "bind \"Alt c\"" = {GoToTab = 8;};
          "bind \"Alt v\"" = {GoToTab = 9;};
          "bind \"Alt g\"" = {GoToTab = 10;};

          "bind \"Alt u\"" = {NewPane = "Down";};
          "bind \"Alt o\"" = {NewPane = "Right";};

          "bind \"Alt t\"" = {MoveTab = "Left";};
          "bind \"Alt y\"" = {MoveTab = "Right";};

          "bind \"Alt n\"" = {NewTab = {name = " ";};};
          "bind \"Alt q\"" = {CloseTab = {};};

          "bind \"Alt a\"" = {CloseFocus = {};};

          "bind \"Alt z\"" = {Detach = {};};
          "bind \"Alt p\"" = {ToggleFloatingPanes = {};};
          "bind \"Alt i\"" = {TogglePaneFrames = {};};
          "bind \"Alt b\"" = {ToggleFocusFullscreen = {};};

          "bind \"Alt F1\"" = {
            SwitchToMode = "EnterSearch";
            SearchInput = 0;
          };
          "bind \"Alt F2\"" = {
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };
          "bind \"Alt F3\"" = {
            SwitchToMode = "Scroll";
          };
          "bind \"Alt F4\"" = {
            SwitchToMode = "Session";
          };
        };
        scroll = {
          "bind \"PageUp\"" = {HalfPageScrollUp = {};};
          "bind \"PageDown\"" = {HalfPageScrollDown = {};};
          "bind \"k\"" = {ScrollUp = {};};
          "bind \"j\"" = {ScrollDown = {};};
          "bind \"Alt F2\"" = {
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };
          "bind \"Alt F1\"" = {
            SwitchToMode = "EnterSearch";
            SearchInput = 0;
          };
          "bind \"Alt F3\"" = {
            SwitchToMode = "Normal";
          };
          "bind \"Alt F4\"" = {
            SwitchToMode = "Session";
          };
        };
        search = {
          "bind \"PageDown\"" = {HalfPageScrollDown = {};};
          "bind \"PageUp\"" = {HalfPageScrollUp = {};};
          "bind \"k\"" = {Search = "up";};
          "bind \"j\"" = {Search = "down";};
          "bind \"c\"" = {SearchToggleOption = "CaseSensitivity";};
          "bind \"w\"" = {SearchToggleOption = "Wrap";};
          "bind \"o\"" = {SearchToggleOption = "WholeWord";};
          "bind \"Alt F2\"" = {
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };
          "bind \"Alt F1\"" = {
            SwitchToMode = "Normal";
          };
          "bind \"Alt F3\"" = {
            SwitchToMode = "Scroll";
          };
        };
        entersearch = {
          "bind \"Esc\"" = {
            SwitchToMode = "Normal";
          };
          "bind \"Alt F2\"" = {
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };
          "bind \"Alt F1\"" = {
            SwitchToMode = "Normal";
          };
          "bind \"Alt F3\"" = {
            SwitchToMode = "Scroll";
          };
        };
        renametab = {
          "bind \"Esc\"" = {
            "UndoRenameTab; SwitchToMode" = "Tab";
          };
          "bind \"Alt F2\"" = {
            "UndoRenameTab; SwitchToMode" = "Tab";
          };
          "bind \"Alt F1\"" = {
            UndoRenameTab = {};
            SwitchToMode = "EnterSearch";
            SearchInput = 0;
          };
          "bind \"Alt F3\"" = {
            UndoRenameTab = {};
            SwitchToMode = "Normal";
          };
        };
      };
      plugins = {
        "tab-bar" = {path = "tab-bar";};
        "status-bar" = {path = "status-bar";};
        "strider" = {path = "strider";};
        "compact-bar" = {path = "compact-bar";};
      };
      themes = {
      };
    };
  };
}

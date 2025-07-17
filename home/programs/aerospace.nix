{lib, ...}: {
  programs.aerospace = {
    enable = true;
    userSettings = {
      accordion-padding = 90;
      # automatically-unhide-macos-hidden-apps = true;
      # on-focused-monitor-changed = ["move-mouse monitor-lazy-center"]; # i3
      # on-focus-changed = ["move-mouse window-lazy-center"];
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      default-root-container-layout = "accordion";
      default-root-container-orientation = "auto";
      start-at-login = true;

      # after-startup-command = [
      #   "exec-and-forget borders active_color=0xfcba03aa inactive_color=0x2b2b2baa width=2.0"
      # ];

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer = {
          left = 8;
          bottom = 8;
          top = 8;
          right = 8;
        };
      };
      on-window-detected = [
        {
          "if".app-name-regex-substring = "login|anmelden|monitor|remote|horizon|whatsapp|finder";
          run = "layout floating";
        }
      ];
      mode = {
        main.binding = {
          # General
          cmd-shift-f = "fullscreen --no-outer-gaps";
          cmd-shift-c = "reload-config";
          cmd-q = "close --quit-if-last-window";
          cmd-shift-t = "enable toggle";
          cmd-shift-minus = "resize smart -50";
          cmd-shift-equal = "resize smart +50";
          # cmd-h = []; # Disable "hide application"
          # cmd-alt-h = []; # Disable "hide others"
          cmd-shift-r = [
            "flatten-workspace-tree"
            "mode main"
          ]; # reset layout

          # Layouts
          cmd-shift-space = "layout floating tiling"; # "floating toggle" in i3
          # cmd-x = "layout tiles horizontal vertical";
          # cmd-y = "layout accordion horizontal vertical";
          # cmd-x = "split horizontal";
          # cmd-y = "split vertical";
          cmd-s = "layout tiles horizontal";
          cmd-v = "layout tiles vertical";
          cmd-shift-s = "layout accordion h_accordion";
          cmd-shift-v = "layout accordion v_accordion";
          cmd-e = "layout tiles horizontal vertical";

          # # Focus
          cmd-h = "focus --boundaries-action wrap-around-the-workspace left";
          cmd-j = "focus --boundaries-action wrap-around-the-workspace down";
          cmd-k = "focus --boundaries-action wrap-around-the-workspace up";
          cmd-l = "focus --boundaries-action wrap-around-the-workspace right";

          # Move
          cmd-shift-h = "move left";
          cmd-shift-j = "move down";
          cmd-shift-k = "move up";
          cmd-shift-l = "move right";

          # Join
          # cmd-shift-h = ["join-with left" "mode main"];
          # cmd-shift-j = ["join-with down" "mode main"];
          # cmd-shift-k = ["join-with up" "mode main"];
          # cmd-shift-l = ["join-with right" "mode main"];
          # cmd-shift-left = "join-with left";
          # cmd-shift-down = "join-with down";
          # cmd-shift-up = "join-with up";
          # cmd-shift-right = "join-with right";

          # Workspace
          cmd-1 = "workspace 1";
          cmd-2 = "workspace 2";
          cmd-3 = "workspace 3";
          cmd-4 = "workspace 4";
          cmd-5 = "workspace 5";

          cmd-shift-1 = "move-node-to-workspace 1";
          cmd-shift-2 = "move-node-to-workspace 2";
          cmd-shift-3 = "move-node-to-workspace 3";
          cmd-shift-4 = "move-node-to-workspace 4";
          cmd-shift-5 = "move-node-to-workspace 5";

          # cmd-tab = "workspace-back-and-forth";
          # cmd-shift-tab = "move-workspace-to-monitor --wrap-around next";

          # Modes
          cmd-shift-semicolon = "mode service";
          cmd-r = "mode resize";

          # Applications
          cmd-b = "exec-and-forget open -a \"/Applications/Brave Browser.app\"";
          cmd-shift-enter = ''
            exec-and-forget osascript -e 'if application "Code" is not running then
              tell application "Visual Studio Code.app" to activate
            else
              tell application "Visual Studio Code.app" to activate
              tell application "System Events" to tell process "Code" to keystroke "n" using {shift down, command down}
            end if'
          '';
          cmd-t = ''
            exec-and-forget osascript -e 'if application "Ghostty" is not running then
              tell application "Ghostty.app" to activate
            else
              tell application "Ghostty.app" to activate
              tell application "System Events" to tell process "Ghostty" to click menu item "New Window" of menu "File" of menu bar 1
            end if'
          '';
        };

        service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];
          r = [
            "flatten-workspace-tree"
            "mode main"
          ]; # reset layout
          f = [
            "layout floating tiling"
            "mode main"
          ]; # Toggle between floating and tiling layout
          backspace = [
            "close-all-windows-but-current"
            "mode main"
          ];

          cmd-shift-h = [
            "join-with left"
            "mode main"
          ];
          cmd-shift-j = [
            "join-with down"
            "mode main"
          ];
          cmd-shift-k = [
            "join-with up"
            "mode main"
          ];
          cmd-shift-l = [
            "join-with right"
            "mode main"
          ];
        };

        resize.binding = {
          h = "resize width -50";
          j = "resize height +50";
          k = "resize height -50";
          l = "resize width +50";
          enter = "mode main";
          esc = "mode main";
        };
      };
    };
  };
}

{lib, ...}: {
  programs.aerospace = {
    enable = true;
    userSettings = {
      accordion-padding = 30;
      # automatically-unhide-macos-hidden-apps = true;
      # on-focused-monitor-changed = ["move-mouse monitor-lazy-center"]; # i3
      on-focus-changed = ["move-mouse window-lazy-center"];
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      start-at-login = true;

      # after-startup-command = [
      #   "exec-and-forget borders active_color=0xfcba03aa inactive_color=0x2b2b2baa width=2.0"
      # ];

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer = {
          left = 10;
          bottom = 10;
          top = 10;
          right = 10;
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
          alt-shift-f = "fullscreen --no-outer-gaps";
          alt-shift-c = "reload-config";
          alt-q = "close --quit-if-last-window";
          alt-shift-t = "enable toggle";
          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";
          # cmd-h = []; # Disable "hide application"
          # cmd-alt-h = []; # Disable "hide others"
          alt-shift-r = [
            "flatten-workspace-tree"
            "mode main"
          ]; # reset layout

          # Layouts
          alt-shift-space = "layout floating tiling"; # "floating toggle" in i3
          # alt-x = "layout tiles horizontal vertical";
          # alt-y = "layout accordion horizontal vertical";
          # alt-x = "split horizontal";
          # alt-y = "split vertical";
          alt-s = "layout tiles horizontal";
          alt-v = "layout tiles vertical";
          alt-shift-s = "layout accordion h_accordion";
          alt-shift-v = "layout accordion v_accordion";
          alt-e = "layout tiles horizontal vertical";

          # # Focus
          alt-h = "focus --boundaries-action wrap-around-the-workspace left";
          alt-j = "focus --boundaries-action wrap-around-the-workspace down";
          alt-k = "focus --boundaries-action wrap-around-the-workspace up";
          alt-l = "focus --boundaries-action wrap-around-the-workspace right";

          # Move
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          # Join
          alt-shift-left = ["join-with left" "mode main"];
          alt-shift-down = ["join-with down" "mode main"];
          alt-shift-up = ["join-with up" "mode main"];
          alt-shift-right = ["join-with right" "mode main"];
          # alt-shift-left = "join-with left";
          # alt-shift-down = "join-with down";
          # alt-shift-up = "join-with up";
          # alt-shift-right = "join-with right";

          # Workspace
          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";

          # alt-tab = "workspace-back-and-forth";
          # alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

          # Modes
          alt-shift-semicolon = "mode service";
          alt-r = "mode resize";

          # Applications
          alt-b = "exec-and-forget open -a \"/Applications/Microsoft Edge.app\"";
          alt-shift-enter = ''
            exec-and-forget osascript -e 'if application "Code" is not running then
              tell application "Visual Studio Code.app" to activate
            else
              tell application "Visual Studio Code.app" to activate
              tell application "System Events" to tell process "Code" to keystroke "n" using {shift down, command down}
            end if'
          '';
          alt-enter = ''
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

          alt-shift-h = [
            "join-with left"
            "mode main"
          ];
          alt-shift-j = [
            "join-with down"
            "mode main"
          ];
          alt-shift-k = [
            "join-with up"
            "mode main"
          ];
          alt-shift-l = [
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

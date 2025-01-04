{
  pkgs,
  username,
  ...
}: {
  imports = [
  ];

  environment.shells = [pkgs.zsh];
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  services = {
    # aerospace = {
    #   enable = true;
    #   package = pkgs.aerospace;
    #   extraConfig = "$HOME/.config/aerospace/aerospace.toml";

    # };
    # raycast = {
    #   enable = true;
    #   package = pkgs.raycast;
    # };
  };

  system = {
    stateVersion = 5;

    defaults = {
      loginwindow.GuestEnabled = false;

      CustomUserPreferences = {
        "com.apple.security.smartcard" = {
          # allowSmartCard = false;
          enforceSmartCard = false;
        };
        "com.apple.commerce".AutoUpdate = true;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.1;
        expose-animation-duration = 0.1;
        launchanim = false;
        mru-spaces = false;
        orientation = "bottom";
        persistent-apps = [
          "${pkgs.spotify}/Applications/Spotify.app"
          "${pkgs.wezterm}/Applications/Wezterm.app"
          "/Applications/Microsoft Edge.app"
          "/Applications/Visual Studio Code.app"
          # "${pkgs.alacritty}/Applications/Alacritty.app"
          # "${pkgs.obsidian}/Applications/Obsidian.app"
        ];
        show-process-indicators = true;
        show-recents = false;
        showhidden = true;
        static-only = false;
        tilesize = 48;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        _FXShowPosixPathInTitle = true;
      };

      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.springing.delay" = 0.1;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15; # 120, 94, 68, 35, 25, 15
        KeyRepeat = 2; # 120, 90, 60, 30, 12, 6, 2
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.001;
      };

      screencapture.location = "~/Pictures/screenshots";
      screensaver.askForPasswordDelay = 10;

      trackpad = {
        Clicking = true;
        # TrackpadThreeFingerDrag = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}

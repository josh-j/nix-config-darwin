{
  pkgs,
  username,
  ...
}: {
  imports = [
  ];

  # environment.systemPackages = with pkgs; [
  # ];

  environment.shells = [pkgs.zsh];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
    ];
    brews = [
    ];

    casks = [
      "anki"
      {
        name = "microsoft-edge";
        greedy = true;
      }
      "ghostty"
      # { name = "brave-browser"; greedy = true; }
      "steam"
      {
        name = "zen-browser";
        greedy = true;
      }
    ];
  };

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

    # activationScripts are executed every time you boot the system or run
    # `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and
      # apply them to the current session, so we do not need to logout and
      # login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      loginwindow.GuestEnabled = false;

      CustomUserPreferences = {
        "com.apple.security.smartcard" = {
          # allowSmartCard = false;
          enforceSmartCard = false;
        };
        "com.apple.commerce".AutoUpdate = true;
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
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
          # "${pkgs.wezterm}/Applications/Wezterm.app"
          "/Applications/Ghostty.app"
          "/Applications/Microsoft Edge.app"
          # "/Applications/Visual Studio Code.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
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
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
      };

      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.springing.delay" = 0.1;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15; # 120, 94, 68, 35, 25, 15
        KeyRepeat = 2; # 120, 90, 60, 30, 12, 6, 2
        NSAutomaticWindowAnimationsEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSWindowResizeTime = 0.001;
        _HIHideMenuBar = true;
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

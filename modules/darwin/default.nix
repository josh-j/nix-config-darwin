{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../programs/aerospace.nix
  ];

  # Package management
  environment.systemPackages = with pkgs; [
    zsh
    zsh-nix-shell
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = ["qmk/qmk"];
    # brews = ["openssl@3" "qmk"];
    casks = [
      "anki"
      "microsoft-edge"
      "ghostty"
      "scroll-reverser"
      "steam"
      "zen-browser"
      "vlc"
    ];
  };

  # System defaults and behavior
  system = {
    stateVersion = 5;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      loginwindow.GuestEnabled = false;

      NSGlobalDomain = {
        # System behavior
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.springing.delay" = 0.1;

        # Interface settings
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        _HIHideMenuBar = true;

        # Performance settings
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.001;

        # File handling
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSTextShowsControlCharacters = true;
        NSDisableAutomaticTermination = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
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
          "/Applications/Ghostty.app"
          "/Applications/Microsoft Edge.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
        ];
        show-process-indicators = true;
        show-recents = false;
        showhidden = true;
        static-only = false;
        tilesize = 48;
      };

      screencapture.location = "~/Pictures/screenshots";
      screensaver.askForPasswordDelay = 10;
      trackpad.Clicking = true;
    };
  };

  # User configuration
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  # # System activation
  # system.activationScripts.postUserActivation.text = ''
  #   # System settings
  #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  #   sudo mdutil -i off / &>/dev/null || true
  # '';
}

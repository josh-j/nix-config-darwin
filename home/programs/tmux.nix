{pkgs, inputs, ...}: let
  # Custom tmux plugins
  # sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "sessionx";
  #   version = "1.0";
  #   # rtpFilePath = "sessionx.tmux";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "omerxx";
  #     repo = "tmux-sessionx";
  #     rev = "42c18389e73b80381d054dd1005b8c9a66942248";
  #     sha256 = "sha256-S/1mcmOrNKkzRDwMLGqnLUbvzUxcO1EcMdPwcipRQuE=";
  #   };
  # };

  minimal-tmux-status = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "minimal-tmux-status";
    version = "1.0";
    rtpFilePath = "minimal.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "niksingh710";
      repo = "minimal-tmux-status";
      rev = "d7188c1aeb1c7dd03230982445b7360f5e230131";
      sha256 = "sha256-JtbuSxWFR94HiUdQL9uIm2V/kwGz0gbVbqvYWmEncbc=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    mouse = true;
    keyMode = "vi";
    shortcut = "a";
    sensibleOnTop = false;
    resizeAmount = 5;

    extraConfig = ''
      # enable terminal compatibility
      set-option -ga terminal-overrides ",screen-256color:Tc"
      set-option -g default-command "''${SHELL}"
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-position bottom

      # Key bindings
      bind ^X lock-server
      bind ^C new-window -c "$HOME"
      bind ^D detach
      bind H previous-window
      bind L next-window
      bind r command-prompt "rename-window %%"
      bind R source-file ~/.config/tmux/tmux.conf
      bind ^A last-window
      bind ^W list-windows
      bind w list-windows
      bind z resize-pane -Z
      bind ^L refresh-client
      bind l refresh-client
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind '"' choose-window
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind-key b set-option status
      bind -r left resize-pane -L 20
      bind -r right resize-pane -R 20
      bind -r down resize-pane -D 7
      bind -r up resize-pane -U 7
      bind : command-prompt
      bind * setw synchronize-panes
      bind P set pane-border-status
      bind c kill-pane
      bind x swap-pane -D
      bind S choose-session
      bind K send-keys "clear"\; send-keys "Enter"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      # {
      #   plugin = resurrect;
      #   extraConfig = ''
      #     set -g @resurrect-strategy-nvim 'session'
      #   '';
      # }
      # {
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #   '';
      # }
      tmux-thumbs
      {
        plugin = inputs.tmux-sessionx.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @sessionx-auto-accept 'off'
          # set -g @sessionx-custom-paths '/home/joshj/Projects/dotfiles'
          set -g @sessionx-bind 'o'
          # set -g @sessionx-x-path '~/Projects/dotfiles'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
      {
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-width '80%'
          set -g @floax-height '80%'
          set -g @floax-border-color 'magenta'
          set -g @floax-text-color 'blue'
          set -g @floax-bind 'p'
          set -g @floax-change-path 'true'
        '';
      }
      {
        plugin = minimal-tmux-status;
        extraConfig = ''
          set -g @minimal-tmux-fg "#808080"
          set -g @minimal-tmux-bg "#3c3c3c"
          set -g @minimal-tmux-status "bottom"
          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-right-arrow ""
          set -g @minimal-tmux-left-arrow ""
          # set -g @minimal-tmux-status-left-extra "#(date +"%b %_d %H:%M")"
          # set -g status-left-length 120
        '';
      }
    ];
  };
}

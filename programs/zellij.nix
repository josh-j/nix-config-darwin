# programs/zellij.nix
{
  pkgs,
  inputs,
  ...
}: let
  plugin_zjstatus = inputs.zjstatus.outputs.packages.${pkgs.stdenv.hostPlatform.system}.default;
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "687f6f2a97ef7c691d623d910989f1a8dfdc0d7e";
    hash = "sha256-tiJ/eDvUPqux33owjE4y5eLGJeT9GW4qQItPSC5i/nc=";
  };
in {
  programs.nushell.shellAliases = {
    he = "zellij -s $'($env.PWD | path basename)-(random int)' --new-session-with-layout /users/joshj/.config/zellij/layouts/helix.kdl";
  };
  # programs.zellij = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = {
  #     default_shell = "zsh";
  #     pane_frames = false;
  #     default_layout = "default_zjstatus";
  #     default_mode = "locked";
  #     on_force_close = "quit";
  #     simplified_ui = true;
  #     theme = "dracula";
  #     ui.pane_frames.hide_session_name = true;
  #     themes.dracula = {
  #       fg = [248 248 242];
  #       bg = [40 42 54];
  #       black = [0 0 0];
  #       red = [255 85 85];
  #       green = [80 250 123];
  #       yellow = [241 250 140];
  #       blue = [98 114 164];
  #       magenta = [255 121 198];
  #       cyan = [139 233 253];
  #       white = [255 255 255];
  #       orange = [255 184 108];
  #     };
  #   };
  # };

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  # Files go into xdg.configFile

  xdg.configFile = {
    "zellij/config.kdl".text =
      builtins.readFile "${toString ../programs/dotfiles}/zellij/helix.kdl"
      + ''
        theme "catppuccin-mocha"
        on_force_close "quit"
        simplified_ui true
        pane_frames true
        ui {
          pane_frames {
            hide_session_name true
            rounded_corners true
          }
        }
      '';
    "zellij/layouts/default_zjstatus.kdl".text = ''
      layout {
           default_tab_template {
               pane size=2 borderless=true {
                   plugin location="file://${plugin_zjstatus}/bin/zjstatus.wasm" {
                       format_left   "{mode}#[bg=#1e1e2e] {tabs}"
                       format_center ""
                       format_right  "#[bg=#1e1e2e,fg=#89b4fa]#[bg=#89b4fa,fg=#181825,bold] #[bg=#313244,fg=#cdd6f4,bold] {session} #[bg=#45475a,fg=#cdd6f4,bold]"
                       format_space  ""
                       format_hide_on_overlength "true"
                       format_precedence "crl"

                       border_enabled  "false"
                       border_char     "─"
                       border_format   "#[fg=#6C7086]{char}"
                       border_position "top"

                       mode_normal        "#[bg=#a6e3a1,fg=#181825,bold] NORMAL#[bg=#45475a,fg=#a6e3a1]█"
                       mode_locked        "#[bg=#585b70,fg=#181825,bold] LOCKED #[bg=#45475a,fg=#585b70]█"
                       mode_resize        "#[bg=#f38ba8,fg=#181825,bold] RESIZE#[bg=#45475a,fg=#f38ba8]█"
                       mode_pane          "#[bg=#89b4fa,fg=#181825,bold] PANE#[bg=#45475a,fg=#89b4fa]█"
                       mode_tab           "#[bg=#b4befe,fg=#181825,bold] TAB#[bg=#45475a,fg=#b4befe]█"
                       mode_scroll        "#[bg=#f9e2af,fg=#181825,bold] SCROLL#[bg=#45475a,fg=#f9e2af]█"
                       mode_enter_search  "#[bg=#89b4fa,fg=#181825,bold] ENT-SEARCH#[bg=#45475a,fg=#89b4fa]█"
                       mode_search        "#[bg=#89b4fa,fg=#181825,bold] SEARCHARCH#[bg=#45475a,fg=#89b4fa]█"
                       mode_rename_tab    "#[bg=#b4befe,fg=#181825,bold] RENAME-TAB#[bg=#45475a,fg=#b4befe]█"
                       mode_rename_pane   "#[bg=#89b4fa,fg=#181825,bold] RENAME-PANE#[bg=#45475a,fg=#89b4fa]█"
                       mode_session       "#[bg=#cba6f7,fg=#181825,bold] SESSION#[bg=#45475a,fg=#cba6f7]█"
                       mode_move          "#[bg=#f2cdcd,fg=#181825,bold] MOVE#[bg=#45475a,fg=#f2cdcd]█"
                       mode_prompt        "#[bg=#89b4fa,fg=#181825,bold] PROMPT#[bg=#45475a,fg=#89b4fa]█"
                       mode_tmux          "#[bg=#fab387,fg=#181825,bold] TMUX#[bg=#45475a,fg=#fab387]█"

                       // formatting for inactive tabs
                       tab_normal              "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{floating_indicator}#[bg=#45475a,fg=#313244,bold]█"
                       tab_normal_fullscreen   "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{fullscreen_indicator}#[bg=#45475a,fg=#313244,bold]█"
                       tab_normal_sync         "#[bg=#45475a,fg=#89b4fa]█#[bg=#89b4fa,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{sync_indicator}#[bg=#45475a,fg=#313244,bold]█"

                       // formatting for the current active tab
                       tab_active              "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{floating_indicator}#[bg=#45475a,fg=#313244,bold]█"
                       tab_active_fullscreen   "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{fullscreen_indicator}#[bg=#45475a,fg=#313244,bold]█"
                       tab_active_sync         "#[bg=#45475a,fg=#fab387]█#[bg=#fab387,fg=#181825,bold]{index} #[bg=#313244,fg=#cdd6f4,bold] {name}{sync_indicator}#[bg=#45475a,fg=#313244,bold]█"

                       // separator between the tabs
                       tab_separator           "#[bg=#1e1e2e] "

                       // indicators
                       tab_sync_indicator       " "
                       tab_fullscreen_indicator " 󰊓"
                       tab_floating_indicator   " 󰹙"

                       command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                       command_git_branch_format      "#[fg=blue] {stdout} "
                       command_git_branch_interval    "10"
                       command_git_branch_rendermode  "static"

                       datetime        "#[fg=#6C7086,bold] {format} "
                       datetime_format "%A, %d %b %Y %H:%M"
                       datetime_timezone "Europe/London"
                   }
               }
               children
           }
       }
    '';

    "zellij/plugins/zellij_forgot.wasm".source = pkgs.fetchurl {
      url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.1/zellij_forgot.wasm";
      sha256 = "1pxwy5ld3affpzf20i1zvn3am12vs6jwp06wbshw4g1xw8drj4ch";
    };

    "zellij/yazi/keymap.toml".text =
      # toml
      ''
        # keymap.toml
        [[manager.prepend_keymap]]
        desc = "Smart filter"
        on = ["F"]
        run = "plugin smart-filter"

        [[manager.prepend_keymap]]
        desc = "Jump to a file/directory via fzf"
        on = ["f"]
        run = "plugin fzf"

        [[manager.prepend_keymap]]
        desc = "Search files by content via ripgrep"
        on = ["z"]
        run = "search --via=rg"

        [[manager.prepend_keymap]]
        desc = "Jump to a directory via zoxide"
        on = ["j"]
        run = "plugin zoxide"
      '';

    "zellij/yazi/yazi.toml".text =
      # toml
      ''
        # yazi.toml

        [manager]
        ratio = [0, 4, 0]

        [opener]
        edit = [
          { run = 'nu ~/.config/zellij/yazi/open_file.nu "$1"', desc = "Open File in a new pane" },
        ]
      '';
    "zellij/yazi/plugins/no-status.yazi".source = "${yazi-plugins}/no-status.yazi";
    "zellij/yazi/plugins/smart-filter.yazi".source = "${yazi-plugins}/smart-filter.yazi";
    # "zellij/yazi/theme.toml".source = "${pkgs.catppuccin-yazi}/themes/mocha/catppuccin-mocha-mauve.toml";
    # "zellij/yazi/Catppuccin-mocha.tmTheme".source = "${pkgs.catppuccin-bat}/themes/Catppuccin Mocha.tmTheme";

    "zellij/yazi/main.lua".text =
      # lua
      ''
        require("no-status"):setup()
      '';

    # "zellij/layouts/helix.kdl".source = ./dotfiles/zellij/helix.kdl;
    # "zellij/layouts/helix.swap.kdl".source = ./dotfiles/zellij/helix.swap.kdl;

    "zellij/layouts/helix.kdl".source = "${toString ../programs/dotfiles}/zellij/helix.kdl";
    "zellij/layouts/helix.swap.kdl".source = "${toString ../programs/dotfiles}/zellij/helix.swap.kdl";

    "zellij/yazi/open_file.nu".text =
      # nu
      ''
        #!/usr/bin/env nu

        export def is_hx_running [list_clients_output: string] {
            let cmd = $list_clients_output | str trim | str downcase

            # Split the command into parts
            let parts = $cmd | split row " "

            # Check if any part ends with 'hx', is 'hx', ends with '.hx-wrapped' or '.hx-wrapped_'
            let has_hx = ($parts | any {|part|
                ($part | str ends-with "/hx") or ($part | str ends-with "/.hx-wrapped") or ($part | str ends-with "/.hx-wrapped_")
            })
            let is_hx = ($parts | any {|part|
                ($part == "hx") or ($part == ".hx-wrapped") or ($part == ".hx-wrapped_")
            })
            let has_or_is_hx = $has_hx or $is_hx

            # Find the position of 'hx' or '.hx-wrapped' variants in the parts
            let hx_positions = ($parts | enumerate | where {|x|
                ($x.item == "hx") or ($x.item == ".hx-wrapped") or ($x.item == ".hx-wrapped_") or ($x.item | str ends-with "/hx") or ($x.item | str ends-with "/.hx-wrapped") or ($x.item | str ends-with "/.hx-wrapped_")
            } | get index)

            # Check if 'hx' or variants are the first part or right after a path
            let is_hx_at_start = if ($hx_positions | is-empty) {
                false
            } else {
                let hx_position = $hx_positions.0
                $hx_position == 0 or ($hx_position > 0 and ($parts | get ($hx_position - 1) | str ends-with "/"))
            }

            let result = $has_or_is_hx and $is_hx_at_start

            # Debug information
            print $"input: list_clients_output = ($list_clients_output)"
            print $"treated input: cmd = ($cmd)"
            print $"  parts: ($parts)"
            print $"  has_hx: ($has_hx)"
            print $"  is_hx: ($is_hx)"
            print $"  has_or_is_hx: ($has_or_is_hx)"
            print $"  hx_positions: ($hx_positions)"
            print $"  is_hx_at_start: ($is_hx_at_start)"
            print $"  Final result: ($result)"
            print ""

            $result
        }

        def main [file_path: path] {
            # Move focus to the next pane
            zellij action focus-next-pane

            # Store the second line of the zellij clients list in a variable
            let list_clients_output = (zellij action list-clients | lines | get 1)

            # Parse the output to remove the first two words and extract the rest
            let running_command = $list_clients_output
                | parse --regex '\w+\s+\w+\s+(?<rest>.*)'  # Use regex to match two words and capture the remaining text as 'rest'
                | get rest  # Retrieve the captured 'rest' part, which is everything after the first two words
                | to text

            # Check if the command running in the current pane is hx
            if (is_hx_running $running_command) {
                # The current pane is running hx, use zellij actions to open the file
                zellij action write 27
                zellij action write-chars $":open \"($file_path)\""
                zellij action write 13
            } else {
                # The current pane is not running hx, so open hx in a new pane
                zellij action new-pane
                sleep 0.5sec

                # Determine the working directory
                let working_dir = if ($file_path | path exists) and ($file_path | path type) == "dir" {
                    $file_path
                } else {
                    $file_path | path dirname
                }

                # Change to the working directory
                zellij action write-chars $"cd ($working_dir)"
                zellij action write 13
                sleep 0.2sec

                # Open Helix
                zellij action write-chars $"hx ($file_path)"
                sleep 0.1sec
                zellij action write 13
                sleep 0.1sec
            }
        }
      '';
  };
}

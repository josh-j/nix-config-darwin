# programs/zellij.nix
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  plugin_zjstatus = inputs.zjstatus.outputs.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  programs.zellij = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      default_shell = "zsh";
      pane_frames = false;
      default_layout = "default_zjstatus";
      default_mode = "locked";
      on_force_close = "quit";
      simplified_ui = true;
      theme = "dracula";
      ui.pane_frames.hide_session_name = true;
      themes.dracula = {
        fg = [248 248 242];
        bg = [40 42 54];
        black = [0 0 0];
        red = [255 85 85];
        green = [80 250 123];
        yellow = [241 250 140];
        blue = [98 114 164];
        magenta = [255 121 198];
        cyan = [139 233 253];
        white = [255 255 255];
        orange = [255 184 108];
      };
    };
  };

  # Files go into xdg.configFile
  xdg.configFile."zellij/layouts/default_zjstatus.kdl".text = ''
    layout {
      pane {}
      pane size=1 borderless=true {
        plugin location="file:${plugin_zjstatus}/bin/zjstatus.wasm" {
          format_left  "{mode} #[fg=#ffffff,bold]{session} {tabs}"
          format_right "{datetime}"
          format_space "|"
          hide_frame_for_single_pane "true"
          mode_normal  "#[bg=#1e1e1e,fg=#ffffff] "
          mode_tmux    "#[bg=#1e1e1e,fg=#ffffff] tmux "
          mode_locked  "#[bg=#1e1e1e,fg=#ffffff] locked "
          border_enabled   "false"
          border_char      "─"
          border_format    "#[fg=#ffffff]"
          border_position  "top"
          tab_normal              "#[fg=#6C7086] {name} "
          tab_normal_fullscreen   "#[fg=#6C7086] {name} [] "
          tab_normal_sync         "#[fg=#6C7086] {name} <> "
          tab_active              "#[bg=#6C7086,fg=#ffffff,bold] {name} "
          tab_active_fullscreen   "#[bg=#6C7086,fg=#ffffff] {name} [] "
          tab_active_sync         "#[bg=#6C7086,fg=#ffffff,bold] {name} <> "
          datetime          "#[fg=#6C7086] {format} "
          datetime_format   "%Y-%m-%d %H:%M"
          datetime_timezone "Europe/Berlin"
        }
      }
    }
  '';
}

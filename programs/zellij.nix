{...}: {
  programs.zellij = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      default_layout = "compact";
      default_mode = "locked";
      on_force_close = "quit";
      theme = "nord";
      ui.pane_frames.rounded_corners = true;
    };
  };

  xdg.configFile."zellij/layouts" = {
    recursive = true;
    source = ./layouts;
  };
}

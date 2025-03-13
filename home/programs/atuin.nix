_: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = false;
    enableNushellIntegration = true;
    # daemon.enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      update_check = true;
      style = "compact";
      keymap_mode = "vim-normal";
      enter_accept = true;
    };
  };
}

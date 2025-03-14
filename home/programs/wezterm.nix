_: {
  programs.wezterm = {
    enable = true;
    # enableZshIntegration = true;
    # enableBashIntegration = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
    # package = inputs.wezterm-nightly.packages.${pkgs.system}.default;
  };
}

{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf pkgs.stdenv.isDarwin true;
  };

  # SSH configuration (common for all platforms)
  services.openssh.enable = lib.mkDefault false;
}

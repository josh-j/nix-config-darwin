{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };

  # SSH configuration (common for all platforms)
  services.openssh.enable = lib.mkDefault false;
}

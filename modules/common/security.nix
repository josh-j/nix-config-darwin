{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };
  
  # System security features
  # SSH configuration for all platforms
  services.openssh.enable = lib.mkDefault false;
}

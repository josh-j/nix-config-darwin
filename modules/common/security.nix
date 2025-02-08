{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };
  
  # System security features
  services.openssh = lib.mkIf (!pkgs.stdenv.isDarwin) {
    enable = lib.mkDefault false;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Darwin-specific SSH configuration
  system.defaults.ssh = lib.mkIf pkgs.stdenv.isDarwin {
    enable = lib.mkDefault false;
  };
}

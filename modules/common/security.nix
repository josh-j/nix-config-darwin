{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };
  
  # System security features
  # SSH configuration for both Linux and Darwin
  services.openssh = lib.mkMerge [
    (lib.mkIf (!pkgs.stdenv.isDarwin) {
      enable = lib.mkDefault false;
    })
    (lib.mkIf pkgs.stdenv.isDarwin {
      enable = lib.mkDefault false;
    })
  ];
}

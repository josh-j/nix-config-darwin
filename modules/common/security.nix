{ config, lib, pkgs, ... }: lib.mkMerge [
  # Base configuration
  {
    # Security settings
    security = {
      pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
    };
  }

  # Darwin-specific settings
  (lib.mkIf pkgs.stdenv.isDarwin {
    services.openssh.enable = lib.mkDefault false;
  })

  # Linux-specific settings
  (lib.mkIf (!pkgs.stdenv.isDarwin) {
    services.openssh.enable = lib.mkDefault false;
  })
]

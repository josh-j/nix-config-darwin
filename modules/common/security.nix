{ config, lib, pkgs, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };
  
  # System security features
  config = lib.mkMerge [
    # Common settings for all platforms
    {
      # Empty base configuration
    }

    # Darwin-specific settings
    (lib.mkIf pkgs.stdenv.isDarwin {
      services.openssh.enable = lib.mkDefault false;
    })

    # Linux-specific settings
    (lib.mkIf (!pkgs.stdenv.isDarwin) {
      services.openssh.enable = lib.mkDefault false;
    })
  ];
}

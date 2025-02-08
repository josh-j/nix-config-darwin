{ config, lib, ... }: {
  # Security settings
  security = {
    pam.enableSudoTouchIdAuth = lib.mkIf (config.system.platform == "darwin") true;
  };
  
  # System security features
  services.openssh = lib.mkIf (!config.system.isDarwin) {
    enable = lib.mkDefault false;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Darwin-specific SSH configuration
  system.defaults.ssh = lib.mkIf config.system.isDarwin {
    enable = lib.mkDefault false;
  };
}

{ config, lib, ... }: {
  # System-wide configuration
  time.timeZone = lib.mkDefault "America/Los_Angeles";
  
  # System features
  services.nix-daemon.enable = true;
  
  # System options
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Always";
      };
    };
  };
}

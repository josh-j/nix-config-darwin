{
inputs,
username,
lib,  # Add lib to the arguments
...
}: {
  nix = {
    configureBuildUsers = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      interval = { Weekday = 0; Hour = 0; Minute = 0; };  # Run at midnight on Sundays
    };
    optimise = {
      automatic = true;
      interval = { Weekday = 0; Hour = 1; Minute = 0; };  # Run at 1 AM on Sundays
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      use-xdg-base-directories = true;
      accept-flake-config = true;
      max-jobs = "auto";
      cores = 0;  # Use all available cores
      build-users-group = "nixbld";
      trusted-users = [
        "${username}"
        "@wheel"
        "@admin"
        "@nixbld"
        "nixbld"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      keep-outputs = true;
      keep-derivations = true;
      system-features = [ "big-parallel" ];
      fallback = true;
      connect-timeout = 5;
      max-substitution-jobs = 32;
      min-free = 5368709120;  # 5GB
      max-free = 26843545600; # 25GB
      timeout = 3600;
    };
    buildMachines = lib.mkDefault [];
    useDaemon = lib.mkDefault true;
    extraOptions = lib.mkDefault ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      keep-going = true
      keep-derivations = true
    '';
  };
  services.nix-daemon.enable = lib.mkDefault true;
}

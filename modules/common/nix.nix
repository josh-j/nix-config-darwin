{ config, lib, ... }: {
  nix = {
    configureBuildUsers = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
    };
    optimise = {
      automatic = true;
      interval = { Weekday = 0; Hour = 1; Minute = 0; };
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      use-xdg-base-directories = true;
      accept-flake-config = true;
      max-jobs = "auto";
      cores = 0;
      build-users-group = "nixbld";
      trusted-users = [
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
      min-free = 5368709120;
      max-free = 26843545600;
      timeout = 3600;
    };
  };
}

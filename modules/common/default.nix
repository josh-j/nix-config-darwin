{
  inputs,
  config,
  username,
  lib, # Add lib to the arguments
  ...
}: {
  nix = {
    enable = lib.mkDefault true;
    gc = lib.mkIf config.nix.enable {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
    optimise.automatic = lib.mkIf config.nix.enable (lib.mkDefault true);
    registry.nixpkgs.flake = lib.mkDefault inputs.nixpkgs;
    settings = {
      experimental-features = lib.mkDefault ["nix-command" "flakes"];
      warn-dirty = lib.mkDefault false;
      use-xdg-base-directories = lib.mkDefault true;
      accept-flake-config = lib.mkDefault true;
      max-jobs = lib.mkDefault 8;
      cores = lib.mkDefault 2;
      build-users-group = lib.mkDefault "nixbld";
      trusted-users = lib.mkDefault [
        "${username}"
        "@wheel"
        "@admin"
        "@nixbld"
        "nixbld"
      ];
      substituters = lib.mkDefault [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = lib.mkDefault [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      keep-outputs = lib.mkDefault true;
      keep-derivations = lib.mkDefault true;
      system-features = lib.mkDefault ["big-parallel" "kvm" "nixos-test"];
      fallback = lib.mkDefault true;
      connect-timeout = lib.mkDefault 5;
    };
    buildMachines = lib.mkDefault [];
    # useDaemon = lib.mkDefault true;
    extraOptions = lib.mkDefault ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      keep-going = true
      keep-derivations = true
    '';
  };
  # services.nix-daemon.enable = lib.mkDefault true;
}

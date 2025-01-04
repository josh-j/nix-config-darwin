{
  inputs,
  pkgs,
  ...
}: {
  # environment.systemPackages = with pkgs; [
  # ];

  nix = {
    configureBuildUsers = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      # dates = "weekly";
    };
    optimise.automatic = true;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      use-xdg-base-directories = true;
      accept-flake-config = true;
      trusted-users = [
        "@wheel"
        "@admin"
      ];
    };
    useDaemon = true;
  };

  services.nix-daemon.enable = true;
}

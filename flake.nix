{
  description = "NixOS and Darwin System Configurations";
  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Misc
    zjstatus.url = "github:dj95/zjstatus";
    zjstatus.inputs.nixpkgs.follows = "nixpkgs";
    # siovim.url = "github:josh-j/siovim";
    # siovim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    with inputs; let
      defaultUser = "joshj";
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [];
        allowBroken = false;
      };
      mkPkgsWithOverlays = system:
        import inputs.nixpkgs {
          inherit system;
          config = nixpkgsConfig;
          overlays = [
            (_: prev: {
              # unstable = import inputs.nixpkgs-unstable {
              #   inherit (prev) system;
              #   config = nixpkgsConfig;
              # };
            })
            (import ./overlays inputs)
          ];
        };
      mkCommonArgs = system: {
        inherit inputs self system;
        channels = {
          inherit nixpkgs;
          nixpkgs-unstable = nixpkgs; # Since you're only using unstable
        };
      };
      mkSystem = {
        system,
        hostname,
        username ? defaultUser,
        extraModules ? [],
      }:
        if builtins.match ".*darwin" system != null
        then
          inputs.nix-darwin.lib.darwinSystem {
            inherit system;
            pkgs = mkPkgsWithOverlays system;
            specialArgs =
              mkCommonArgs system
              // {
                inherit hostname username;
              };
            modules =
              [
                ./modules/common
                ./modules/darwin
                # home-manager.darwinModules.home-manager
                # (import (./hosts + "/${hostname}"))
                home-manager.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = mkCommonArgs system // {inherit hostname username;};
                  # home-manager.users.${username} = import (./hosts + "/${hostname}");

                  # home-manager.users.${username} = import (./hosts + "/${hostname}/default.nix");
                }
                (import (./home + "/${hostname}.nix"))
              ]
              ++ extraModules;
          }
        else {};
    in {
      darwinConfigurations = {
        mbam1 = mkSystem {
          system = "aarch64-darwin";
          hostname = "mbam1";
        };
      };
      # nix code formatter
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };
}

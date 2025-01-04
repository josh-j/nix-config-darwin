{
  description = "NixOS and Darwin System Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    siovim.url = "github:josh-j/siovim";
    siovim.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    agenix,
    ...
  }: let
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
            unstable = import inputs.nixpkgs-unstable {
              inherit (prev) system;
              config = nixpkgsConfig;
            };
          })
          (import ./overlays inputs)
        ];
      };

    mkCommonArgs = system: {
      inherit inputs self system;
      inherit (inputs) nixpkgs nix-index-database;
      channels.nixpkgs = inputs.nixpkgs;
      channels.nixpkgs-unstable = inputs.nixpkgs-unstable;
      pkgs = mkPkgsWithOverlays system;
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
          specialArgs = mkCommonArgs system // {inherit hostname username;};
          modules =
            [
              ./modules/common
              ./modules/darwin
              inputs.home-manager.darwinModules.home-manager
              inputs.nix-homebrew.darwinModules.nix-homebrew
              # inputs.agenix.nixosModules.default
              inputs.agenix.darwinModules.default
              {
                nix-homebrew = {
                  enable = true;
                  enableRosetta = false;
                  user = username;
                  mutableTaps = true;
                  autoMigrate = true;

                  taps = {
                    "homebrew/homebrew-core" = inputs.homebrew-core;
                    "homebrew/homebrew-cask" = inputs.homebrew-cask;
                    "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                  };
                };
              }
              (import (./hosts + "/${hostname}"))
            ]
            ++ extraModules;
        }
      else if builtins.match ".*linux" system != null
      then
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = mkCommonArgs system // {inherit hostname username;};
          modules =
            [
              ./modules/common
              ./modules/linux
              inputs.home-manager.nixosModules.home-manager
              agenix.nixosModules.default
              (import (./hosts + "/${hostname}"))
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

    nixosConfigurations = {
      wslhost = mkSystem {
        system = "x86_64-linux";
        hostname = "wslhost";
        extraModules = [inputs.nixos-wsl.nixosModules.wsl];
      };
    };
  };
}

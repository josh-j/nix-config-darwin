{
  description = "NixOS and Darwin System Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-wsl.url = "github:nix-community/NixOS-WSL";
    # nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nix-index.url = "github:nix-community/nix-index";
    # nix-index.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
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
    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };

    # Misc
    # ghostty.url = "github:ghostty-org/ghostty";
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";
    tmux-sessionx.inputs.nixpkgs.follows = "nixpkgs";
    siovim.url = "github:josh-j/siovim";
    siovim.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    with inputs;
    let
      defaultUser = "joshj";

      nixpkgsConfig = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [ ];
        allowBroken = false;
      };

      mkPkgsWithOverlays =
        system:
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
        channels = {
          inherit nixpkgs nixpkgs-unstable;
        };
      };

      mkSystem =
        {
          system,
          hostname,
          username ? defaultUser,
          extraModules ? [ ],
        }:
        if builtins.match ".*darwin" system != null then
          inputs.nix-darwin.lib.darwinSystem {
            inherit system;
            pkgs = mkPkgsWithOverlays system;
            specialArgs = mkCommonArgs system // {
              inherit hostname username;
            };
            modules = [
              # ./modules/common
              ./modules/darwin

              nix-homebrew.darwinModules.nix-homebrew
              {
                nix-homebrew = {
                  enable = true;
                  enableRosetta = false;
                  user = username;
                  autoMigrate = true;

                  # Add your taps
                  taps = {
                    "homebrew/homebrew-core" = homebrew-core;
                    "homebrew/homebrew-cask" = homebrew-cask;
                    "homebrew/homebrew-bundle" = homebrew-bundle;
                    "homebrew/homebrew-services" = homebrew-services;
                  };

                  mutableTaps = false; # Set to false if you want fully declarative tap management
                };
              }

              mac-app-util.darwinModules.default
              home-manager.darwinModules.home-manager
              (_: {
                home-manager.sharedModules = [
                  mac-app-util.homeManagerModules.default
                ];
              })
              (import (./hosts + "/${hostname}"))
            ] ++ extraModules;
          }
        else if builtins.match ".*linux" system != null then
          inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = mkCommonArgs system // {
              inherit hostname username;
            };
            modules = [
              ./modules/common
              ./modules/linux
              inputs.home-manager.nixosModules.home-manager
              (import (./hosts + "/${hostname}"))
            ] ++ extraModules;
          }
        else
          { };
    in
    {
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
          extraModules = [ inputs.nixos-wsl.nixosModules.wsl ];
        };
      };
      # nix code formatter
      formatter.${system} = nixpkgs.${system}.alejandra;
    };
}

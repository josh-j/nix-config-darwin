{
  description = "NixOS and Darwin System Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-wsl.url = "github:nix-community/NixOS-WSL";
    # nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index.url = "github:nix-community/nix-index";
    nix-index.inputs.nixpkgs.follows = "nixpkgs";

    # Misc
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";
    siovim.url = "github:josh-j/siovim";
    siovim.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs:
    with inputs; let
      isDarwin = system: builtins.match ".*darwin" system != null;
      isLinux = system: builtins.match ".*linux" system != null;
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
              stable = import inputs.nixpkgs-stable {
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
          inherit nixpkgs nixpkgs-stable;
        };
      };

      mkSystem = {
        system,
        hostname,
        username ? defaultUser,
        profile ? "default",
        roles ? [],
        environment ? "development",
        extraModules ? [],
      }: let
        baseModules = [
          ./modules/common
          ./environments/default.nix
        ] ++ (map (role: ./roles/default.nix) roles);
        
        darwinModules = if isDarwin system then [
          ./modules/darwin
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          (_: {
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          })
        ] else [];
        
        linuxModules = if isLinux system then [
          ./modules/linux
          home-manager.nixosModules.home-manager
        ] else [];
        
      in if isDarwin system then
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;
          pkgs = mkPkgsWithOverlays system;
          specialArgs = mkCommonArgs system // {inherit hostname username;};
          modules = baseModules ++ darwinModules ++ [
            (import (./hosts + "/${hostname}"))
          ] ++ extraModules;
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

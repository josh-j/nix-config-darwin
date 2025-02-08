{ environment ? "development", ... }: 
let
  envs = {
    production = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      nix.optimise.automatic = true;
    };

    development = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
      nix.settings.trusted-users = ["@wheel" "@admin"];
    };

    testing = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 1d";
      };
    };
  };
in
  envs.${environment} or envs.development

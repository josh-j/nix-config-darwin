{ config, lib, pkgs, ... }: 
let
  environment = config.environmentType or "development";
  envs = {
    production = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 30d";
        interval = { Day = 1; Hour = 3; Minute = 0; };  # Monthly at 3 AM
      };
      nix.optimise = {
        automatic = true;
        interval = { Day = 1; Hour = 4; Minute = 0; };  # Monthly at 4 AM
      };
    };

    development = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        interval = { Weekday = 0; Hour = 2; Minute = 0; };  # Weekly at 2 AM on Sundays
      };
      nix.settings.trusted-users = ["@wheel" "@admin"];
    };

    testing = {
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 1d";
        interval = { Hour = 1; Minute = 0; };  # Daily at 1 AM
      };
    };
  };
in {
  options = {
    environmentType = lib.mkOption {
      type = lib.types.enum [ "production" "development" "testing" ];
      default = "development";
      description = "The type of environment to configure";
    };
  };

  config = envs.${environment} or envs.development;
}

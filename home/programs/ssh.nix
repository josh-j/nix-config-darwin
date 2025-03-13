{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    includes = [
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "${config.home.homeDirectory}/.ssh/config_external"
      )
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "${config.home.homeDirectory}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "${config.home.homeDirectory}/.ssh/id_github"
          )
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "${config.home.homeDirectory}/.ssh/id_github"
          )
        ];
      };
    };
  };
}

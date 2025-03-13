{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  # credits: https://github.com/jaredmontoya/home-manager/commit/0b2179ce3e2627380fcf0d4db3f05c1182d56474
  hmSessionVars = pkgs.runCommand "hm-session-vars.nu" {} ''
    echo "if ('__HM_SESS_VARS_SOURCED' not-in \$env) {$(${
      lib.getExe pkgs.nushell
    } -c "
      source ${pkgs.callPackage ./capture-foreign-env.nix {}}
      open ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh | capture-foreign-env | to nuon
    ") | load-env}" >> "$out"
  '';
  nuScripts = "${pkgs.nu_scripts}/share/nu_scripts";
  mkCompletions = names:
    concatStringsSep "\n" (
      map (name: "source \"${nuScripts}/custom-completions/${name}/${name}-completions.nu\"") names
    );
in {
  programs.nushell = {
    enable = true;
    extraLogin = ''
      source ${hmSessionVars}
    '';
    settings = {
      show_banner = false;
    };
    plugins = [
      pkgs.nushellPlugins.gstat
      pkgs.custom.nu_plugin_audio_hook
      pkgs.custom.nu_plugin_clipboard
      pkgs.custom.nu_plugin_desktop_notifications
      # nu_plugin_dns
      pkgs.custom.nu_plugin_emoji
      pkgs.custom.nu_plugin_file
    ];
    # extraEnv = ''
    #   use std "path add"
    #   # Local bin
    #   path add $"($env.HOME | path join ".local/bin")"
    #  '';
    shellAliases = {
      cd = "z";
      vi = "hx";
      vim = "hx";
      nano = "hx";
      nix-prefetch-github = "nix-prefetch-github --nix";
      ll = "ls -l";
      c = "clear";
      do = "sudo";
      lix = "nix";
      writeusb = "sudo dd bs=4M oflag=sync status=progress";
    };
  };
}

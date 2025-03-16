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
    # extraLogin = ''
    #   source ${hmSessionVars}
    # '';

    extraLogin = ''
      source ${hmSessionVars}
      $env.__NIX_DARWIN_SET_ENVIRONMENT_DONE = 1

      $env.PATH = [
          "/opt/homebrew/bin"
          $"($env.HOME)/.nix-profile/bin"
          $"/etc/profiles/per-user/($env.USER)/bin"
          "/run/current-system/sw/bin"
          "/nix/var/nix/profiles/default/bin"
          "/usr/local/bin"
          "/usr/bin"
          "/usr/sbin"
          "/bin"
          "/sbin"
      ] ++ ($env.PATH | split row (char esep)) | uniq
      $env.NIX_PATH = [
          $"darwin-config=($env.HOME)/.nixpkgs/darwin-configuration.nix"
          "/nix/var/nix/profiles/per-user/root/channels"
      ]
      $env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
      $env.TERMINFO_DIRS = [
          $"($env.HOME)/.nix-profile/share/terminfo"
          $"/etc/profiles/per-user/($env.USER)/share/terminfo"
          "/run/current-system/sw/share/terminfo"
          "/nix/var/nix/profiles/default/share/terminfo"
          "/usr/share/terminfo"
      ]
      $env.XDG_CONFIG_DIRS = [
          $"($env.HOME)/.nix-profile/etc/xdg"
          $"/etc/profiles/per-user/($env.USER)/etc/xdg"
          "/run/current-system/sw/etc/xdg"
          "/nix/var/nix/profiles/default/etc/xdg"
      ]
      $env.XDG_DATA_DIRS = [
          $"($env.HOME)/.nix-profile/share"
          $"/etc/profiles/per-user/($env.USER)/share"
          "/run/current-system/sw/share"
          "/nix/var/nix/profiles/default/share"
      ]
      $env.NIX_USER_PROFILE_DIR = $"/nix/var/nix/profiles/per-user/($env.USER)"
      $env.NIX_PROFILES = [
          "/nix/var/nix/profiles/default"
          "/run/current-system/sw"
          $"/etc/profiles/per-user/($env.USER)"
          $"($env.HOME)/.nix-profile"
      ]

      if ($"($env.HOME)/.nix-defexpr/channels" | path exists) {
          $env.NIX_PATH = ($env.PATH | split row (char esep) | append $"($env.HOME)/.nix-defexpr/channels")
      }

      if (false in (ls -l `/nix/var/nix`| where type == dir | where name == "/nix/var/nix/db" | get mode | str contains "w")) {
          $env.NIX_REMOTE = "daemon"
      }
    '';
    settings = {
      show_banner = false;
    };
    plugins = [
      # pkgs.nushellPlugins.gstat
      # pkgs.custom.nu_plugin_audio_hook
      # pkgs.custom.nu_plugin_clipboard
      # pkgs.custom.nu_plugin_desktop_notifications
      # nu_plugin_dns
      # pkgs.custom.nu_plugin_emoji
      # pkgs.custom.nu_plugin_file
    ];
    # extraEnv = ''
    #   use std "path add"
    #   # Local bin
    #   # path add $"($env.HOME | path join ".local/bin")"
    #   path add /usr/bin/
    #   path add /usr/local/bin/
    #   path add /bin
    #   path add /usr/sbin
    #   path add /sbin
    #   path add /nix/var/nix/profiles/default/bin
    #   path add /run/current-system/sw/bin
    # '';
    # $env.PATH = '[/Users/joshj/.nix-profile/bin, /etc/profiles/per-user/joshj/bin, /run/current-system/sw/bin, /nix/var/nix/profiles/default/bin, /usr/local/bin, /usr/bin, /bin, /usr/sbin, /sbin]'
    shellAliases = {
      cd = "z";
      vi = "hx";
      vim = "hx";
      nano = "hx";
      gc = "nix-collect-garbage --delete-old";
      nix-prefetch-github = "nix-prefetch-github --nix";
      ll = "ls -l";
      c = "clear";
      do = "sudo";
      lix = "nix";
      writeusb = "sudo dd bs=4M oflag=sync status=progress";
    };
  };
}

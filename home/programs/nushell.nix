{
  pkgs,
  lib,
  config,
  ...
}: let
  # credits: https://github.com/jaredmontoya/home-manager/commit/0b2179ce3e2627380fcf0d4db3f05c1182d56474
  hmSessionVars = pkgs.runCommand "hm-session-vars.nu" {} ''
    echo "if ('__HM_SESS_VARS_SOURCED' not-in \$env) {$(${
      lib.getExe pkgs.nushell
    } -c "
      source ${pkgs.callPackage ./capture-foreign-env.nix {}}
      open ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh | capture-foreign-env | to nuon
    ") | load-env}" >> "$out"
  '';
in {
  programs.nushell = with pkgs; {
    enable = true;
    extraLogin = ''
      source ${hmSessionVars}
    '';
    settings = {
      show_banner = false;
    };

    extraEnv = ''
      use std "path add"
      # Local bin
      path add $"($env.HOME | path join ".local/bin")"

      # # ssh-agent
      # do --env {
      #     let ssh_agent_file = (
      #         $nu.temp-path | path join $"ssh-agent-($env.USER).nuon"
      #     )

      #     if ($ssh_agent_file | path exists) {
      #         let ssh_agent_env = open ($ssh_agent_file)
      #         if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
      #             load-env $ssh_agent_env
      #             return
      #         } else {
      #             rm $ssh_agent_file
      #         }
      #     }

      #     let ssh_agent_env = ^ssh-agent -c
      #         | lines
      #         | first 2
      #         | parse "setenv {name} {value};"
      #         | transpose --header-row
      #         | into record
      #     load-env $ssh_agent_env
      #     $ssh_agent_env | save --force $ssh_agent_file
      # }

      # # Add keys to ssh-agent
      # use std
      # try { ^ssh-add o+e> (std null-device) }
    '';
    shellAliases = {
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

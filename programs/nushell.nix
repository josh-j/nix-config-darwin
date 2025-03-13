{pkgs, ...}: {
  programs.nushell = with pkgs; {
    enable = true;
    # extraPackages = [
    #   lsof
    #   # must be in PATH
    #   nu_plugin_clipboard
    #   nu_plugin_desktop_notifications
    #   nu_plugin_emoji
    #   nu_plugin_file
    # ];
    # plugins = [
    #   nushellPlugins.gstat
    #   nu_plugin_audio_hook
    #   nu_plugin_clipboard
    #   nu_plugin_desktop_notifications
    #   # nu_plugin_dns
    #   nu_plugin_emoji
    #   nu_plugin_file
    # ];
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

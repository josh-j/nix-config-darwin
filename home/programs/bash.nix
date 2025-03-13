{lib, ...}: {
  programs.bash = {
    enable = true;
    bashrcExtra = lib.mkBefore ''
      source /etc/bashrc
    '';
  };
}

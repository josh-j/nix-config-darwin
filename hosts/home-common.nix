{
  pkgs,
  username,
  ...
}: let
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  stable-packages = with pkgs; [
    # Development tools
    direnv
    docker
    docker-compose
    gh
    gnupg
    httpie
    just
    lazygit
    mkcert
    sshs # TUI for ~/.ssh/config
    tldr # tdlr for shell commands

    # System tools
    mkalias
    unstable.fd # fast find
    unstable.mosh # better ssh
    unstable.procs # better ps
    unstable.ripgrep
    unstable.sd # better sed and awk
    unstable.unzip
    unstable.evil-helix # better no-config vim
    unstable.wget
    unstable.yazi
    unstable.zip

    # Terminal and shell
    # atuin
    carapace # multi-environment shell completion
    eza
    fzf
    unstable.bat
    unstable.bottom # system monitor
    unstable.coreutils
    unstable.curl
    unstable.du-dust # better du cmd
    unstable.findutils
    unstable.git-crypt
    unstable.htop
    unstable.jq
    unstable.killall
    # oh-my-zsh
    # zsh
    # zsh-autosuggestions
    # zsh-syntax-highlighting
  ];
in {
  imports = [
    ../programs/git.nix
    ../programs/ssh.nix
  ];
  home = {
    inherit username homeDirectory;

    packages = stable-packages;
    sessionPath = [
      # "$HOME/.local/bin"
      # "$HOME/.local/share/bin"
      "/opt/homebrew/bin" # FIXME don't add if not darwin
    ];

    sessionVariables = let
      getSecret = key: ''
        $(if [ -f "$HOME/.secrets.json" ]; then
          jq -r '.${key} // empty' "$HOME/.secrets.json"
        fi)'';
    in {
      aiservice_API_KEY = getSecret "aiservice_api";
      GITHUB_TOKEN = getSecret "github_token"; # Example of another secret
      OPENAI_API_KEY = getSecret "openai_api"; # Another example
      # Add as many secrets as you need
    };

    stateVersion = "24.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = false;
    };
  };
}

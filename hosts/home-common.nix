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

    # Terminal and shell
    # atuin
    carapace # multi-environment shell completion
    eza
    fzf
    # oh-my-zsh
    # zsh
    # zsh-autosuggestions
    # zsh-syntax-highlighting
  ];
  unstable-packages = with pkgs.unstable; [
    # System tools
    fd # fast find
    mosh # better ssh
    procs # better ps
    ripgrep
    sd # better sed and awk
    unzip
    evil-helix # better no-config vim
    wget
    yazi
    zip

    # Terminal and shell
    bat
    bottom # system monitor
    coreutils
    curl
    du-dust # better du cmd
    findutils
    git-crypt
    htop
    jq
    killall
  ];
in {
  imports = [
    ../programs/git.nix
    ../programs/ssh.nix
  ];
  home = {
    inherit username homeDirectory;

    packages = stable-packages ++ unstable-packages;
    sessionPath = [
      # "$HOME/.local/bin"
      # "$HOME/.local/share/bin"
      "/opt/homebrew/bin"
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

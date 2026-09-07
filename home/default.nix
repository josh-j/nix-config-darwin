{
  pkgs,
  username,
  ...
}: let
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  extraPackages = with pkgs; [
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
    fd # fast find
    mosh # better ssh
    procs # better ps
    ripgrep
    sd # better sed and awk
    unzip
    # evil-helix # better no-config vim
    wget
    # yazi
    zip

    # Terminal and shell
    carapace # multi-environment shell completion
    eza
    fzf
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
    # oh-my-zsh
    # zsh
    # zsh-autosuggestions
    # zsh-syntax-highlighting
  ];
in {
  imports = [
    ./programs/git.nix
    ./programs/ssh.nix
  ];
  home = {
    inherit username homeDirectory;

    packages = extraPackages;
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.local/share/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
      "/etc/profiles/per-user/${username}/bin"
      # "/opt/homebrew/bin" # FIXME don't add if not darwin
    ];

    sessionVariables = let
      getSecret = key: ''
        $(if [ -f "$HOME/.secrets.json" ]; then
          jq -r '.${key} // empty' "$HOME/.secrets.json"
        fi)'';
    in {
      GITHUB_TOKEN = getSecret "github_token"; # Example of another secret
      OPENAI_API_KEY = getSecret "openai_api"; # Another example
      OPENROUTER_API_KEY = getSecret "openrouter_api"; # Another example
      GOOGLE_API_KEY = getSecret "googleai_api_key"; # Another example
      # Add as many secrets as you need
    };
    shell.enableNushellIntegration = true;

    stateVersion = "24.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = false;
      # enableNushellIntegration = true;
    };
  };
}

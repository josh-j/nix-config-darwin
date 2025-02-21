{
  pkgs,
  inputs,
  username,
  ...
}: let
  extraPackages = with pkgs; [
    # Development tools
    unstable.aider-chat
    tree-sitter
    fx # JSON viewer in terminal
    git-crypt
    zed-editor

    # C/CPP
    gcc
    ccls # c / c++

    # Go
    go
    gopls
    golangci-lint

    # Javascript
    nodejs
    nodePackages.npm
    nodePackages.prettier
    typescript
    # nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-langservers-extracted # html, css, json, eslint

    # LSP
    neocmakelsp

    # Lua
    lua
    luarocks
    sumneko-lua-language-server
    lua52Packages.luacheck

    # Nix
    nixd
    alejandra
    deadnix # nix
    # nixfmt-rfc-style
    statix # nix

    # Powershell
    powershell

    # Python
    urnicorn
    pyenv
    xz
    virtualenv
    python3
    python3Packages.pip
    black # python
    ruff # python
    uv

    # Rust
    cargo-cache
    cargo-expand
    rustup

    # Sh
    shellcheck
    shfmt

    # Sql
    sqlfluff

    # Terraform
    tflint

    # System tools
    # clippy
    glow
    mkalias
    pngpaste

    # Terminal and shell
    neofetch
    wakeonlan

    # UI
    vscode
    siovim
    spotify
    obsidian
  ];
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit username inputs;
    };
    users.${username} = {...}: {
      imports = [
        ../home-common.nix
        ../../programs/atuin.nix
        ../../programs/bash.nix
        ../../programs/direnv.nix
        # ../../programs/fonts.nix
        ../../programs/fzf.nix
        ../../programs/starship.nix
        ../../programs/tmux.nix
        ../../programs/wezterm.nix
        ../../programs/zellij.nix
        ../../programs/zoxide.nix
        ../../programs/zsh.nix
      ];
      nix.enable = false;
      home = {
        packages = extraPackages;
        # sessionPath = [
        #   "/nix/var/nix/profiles/default/bin"
        # ];
        file = {
          # ".aerospace.toml".text = builtins.readFile ../../programs/dotfiles/aerospace/aerospace.toml;
          ".config/ghostty/config".text = builtins.readFile ../../programs/dotfiles/ghostty/config;
        };
      };
    };
  };
}

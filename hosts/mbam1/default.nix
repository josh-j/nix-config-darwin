{
  pkgs,
  inputs,
  username,
  ...
}: let
  extraPackages = with pkgs; [
    # Development tools
    tree-sitter
    unstable.fx # JSON viewer in terminal
    unstable.git-crypt
    unstable.zed-editor

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
    unstable.neocmakelsp

    # Lua
    lua
    luarocks
    sumneko-lua-language-server
    lua52Packages.luacheck

    # Nix
    nil
    alejandra
    deadnix # nix
    nixpkgs-fmt
    statix # nix

    # Powershell
    powershell

    # Python
    virtualenv
    python3
    python3Packages.pip
    black # python
    ruff # python
    unstable.uv

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
    # oh-my-zsh
    # starship
    # zoxide
    # zsh
    # zsh-autosuggestions
    # zsh-syntax-highlighting

    # UI
    aerospace
    # raycast
    # microsoft-edge
    vscode
    siovim
    # jeezyvim
    # neovim
    # ...
    # steam
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
        ../../programs/zoxide.nix
        ../../programs/zsh.nix
      ];
      home = {
        packages = extraPackages;
        file = {
          ".aerospace.toml".text = builtins.readFile ../../programs/dotfiles/aerospace/aerospace.toml;
          ".config/ghostty/config".text = builtins.readFile ../../programs/dotfiles/ghostty/config;
        };
      };
    };
  };
}

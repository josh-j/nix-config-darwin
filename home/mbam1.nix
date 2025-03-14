{
  pkgs,
  inputs,
  username,
  ...
}: let
  extraPackages = with pkgs; [
    # Development tools
    aider-chat
    gitui
    yq
    envsubst
    # flake8
    tree-sitter
    fx # JSON viewer in terminal
    git-crypt
    # zed-editor

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
    # unstable.nodePackages.assist-code

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
    nixfmt-rfc-style
    statix # nix

    # Powershell
    powershell

    # Python
    # unicorn
    pyenv
    xz
    virtualenv
    python3
    python3Packages.pip
    python3Packages.flake8
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
    zed
    # siovim
    # spotify
    # obsidian
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
        ./default.nix
        ./programs/aerospace.nix
        ./programs/aichat.nix
        # ../../programs/atuin.nix
        ./programs/bash.nix
        ./programs/direnv.nix
        # ../../programs/ghostty.nix
        # ../../programs/fonts.nix
        ./programs/fzf.nix
        ./programs/helix.nix
        # ./programs/nushell.nix
        ./programs/starship.nix
        # ../../programs/tmux.nix
        ./programs/wezterm.nix
        ./programs/yazi.nix
        ./programs/zellij.nix
        ./programs/zoxide.nix
        ./programs/zsh.nix
      ];
      nix.enable = false;
      home = {
        packages = extraPackages;
        file = let
          dotfilesDir = ./programs/dotfiles;

          # List of files to exclude (those causing conflicts)
          excludeFiles = [
            "wezterm/wezterm.lua"
            # "zellij/config.kdl"
          ];

          # Function to check if a file should be excluded
          shouldExclude = path:
            builtins.any (exclude: path == exclude) excludeFiles;

          # Function to copy files from a directory
          copyFiles = dir: prefix: let
            entries = builtins.readDir dir;
            processEntry = name: type:
              if type == "regular" && !shouldExclude "${prefix}${name}"
              then {".config/${prefix}${name}" = {source = dir + "/${name}";};}
              else if type == "directory"
              then copyFiles (dir + "/${name}") "${prefix}${name}/"
              else {};
          in
            builtins.foldl' (
              acc: name:
                acc // (processEntry name (builtins.getAttr name entries))
            ) {} (builtins.attrNames entries);
        in
          copyFiles dotfilesDir "";
      };
    };
  };
}

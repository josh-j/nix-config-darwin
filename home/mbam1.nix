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
        ./programs/aichat.nix
        # ../../programs/atuin.nix
        ./programs/bash.nix
        ./programs/direnv.nix
        # ../../programs/ghostty.nix
        # ../../programs/fonts.nix
        ./programs/fzf.nix
        ./programs/helix.nix
        ./programs/nushell.nix
        ./programs/starship.nix
        # ../../programs/tmux.nix
        ./programs/wezterm.nix
        ./programs/yazi.nix
        ./programs/zellij.nix
        ./programs/zoxide.nix
        # ../../programs/zsh.nix
      ];
      nix.enable = false;
      home = {
        packages = extraPackages;
        file = let
          # Function to copy a directory structure recursively
          copyDir = dir: prefix: let
            # Get all entries in the current directory
            entries = builtins.readDir dir;
            # Map each entry to the appropriate Nix config
            entryToFile = name: type:
              if type == "regular"
              then
                # If it's a regular file, add it to the configuration
                {"${prefix}/${name}" = {source = dir + "/${name}";};}
              else if type == "directory"
              then
                # If it's a directory, recursively process it
                copyDir (dir + "/${name}") "${prefix}/${name}"
              else {};
          in
            builtins.foldl' (
              acc: name:
                acc // (entryToFile name (builtins.getAttr name entries))
            ) {} (builtins.attrNames entries);
        in
          copyDir ./programs/dotfiles ".config";
      };
    };
  };
}

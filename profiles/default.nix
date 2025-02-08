{
  minimal = {...}: {
    # Minimal system configuration
    programs = {
      git.enable = true;
      zsh.enable = true;
      direnv.enable = true;
    };
  };

  full = {...}: {
    # Full-featured configuration
    imports = [
      ./minimal
    ];
    programs = {
      vscode.enable = true;
      firefox.enable = true;
      tmux.enable = true;
    };
  };

  developer = {...}: {
    # Developer-focused configuration
    imports = [
      ./minimal
    ];
    programs = {
      vscode.enable = true;
      docker.enable = true;
      direnv.enable = true;
    };
  };
}

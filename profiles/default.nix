{
  minimal = {...}: {
    # Minimal system configuration
    home-manager.users.joshj = {
      programs = {
        git.enable = true;
        zsh.enable = true;
        direnv.enable = true;
      };
    };
  };

  full = {...}: {
    # Full-featured configuration
    imports = [
      ./minimal
    ];
    home-manager.users.joshj = {
      programs = {
        vscode.enable = true;
        tmux.enable = true;
      };
    };
  };

  developer = {...}: {
    # Developer-focused configuration
    imports = [
      ./minimal
    ];
    home-manager.users.joshj = {
      programs = {
        vscode.enable = true;
        docker.enable = true;
        direnv.enable = true;
      };
    };
  };
}

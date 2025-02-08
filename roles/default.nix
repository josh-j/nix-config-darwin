{
  desktop = {...}: {
    # Desktop-specific configuration
    programs.vscode.enable = true;
    programs.firefox.enable = true;
  };
  
  server = {...}: {
    # Server-specific configuration
    services.openssh.enable = true;
    networking.firewall.enable = true;
  };

  development = {...}: {
    # Development environment configuration
    programs.git.enable = true;
    programs.direnv.enable = true;
  };
}

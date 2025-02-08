{
  desktop = { pkgs, ... }: {
    # Desktop-specific configuration
    home-manager.users.joshj.home.packages = with pkgs; [ 
      firefox
      vscode 
    ];
  };
  
  server = {...}: {
    # Server-specific configuration
    services.openssh.enable = true;
    networking.firewall.enable = true;
  };

  development = { ... }: {
    # Development environment configuration
    home-manager.users.joshj = {
      programs.git.enable = true;
      programs.direnv.enable = true;
    };
  };
}

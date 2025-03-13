_: {
  programs.git = {
    enable = true;
    ignores = ["*.swp"];
    userName = "joshj";
    userEmail = "joshj.tx@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = false;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}

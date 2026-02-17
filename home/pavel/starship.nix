{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 100;
    };
    enableZshIntegration = true;
  };
}

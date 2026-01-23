{ ... }:
{
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };
  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
  };
}

{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraPackages = with pkgs; [
      gamescope
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
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

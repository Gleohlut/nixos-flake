{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    heroic
    gamescope
    gamescope-wsi
    protonup-qt
    gamemode
  ];
}

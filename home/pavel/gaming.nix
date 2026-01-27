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
  programs.mangohud = {
    enable = true;
    settings = {
      fps_limit = 0;
      preset = 1;
    };
  };
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprlock
  ];
  programs.rofi.enable = true;
}

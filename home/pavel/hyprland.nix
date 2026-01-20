{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    rofi
  ];
}

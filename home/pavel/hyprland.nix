{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    waybar
  ];
  programs.rofi.enable = true;
}

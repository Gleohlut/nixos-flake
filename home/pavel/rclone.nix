{ pkgs, ... }:
{
  programs.rclone = {
    enable = true;
  };
  home.packages = [
    pkgs.filen-cli
  ];
}

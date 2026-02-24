{ config, pkgs, ... }:
{
  home.username = "vanessa";
  home.homeDirectory = "/home/vanessa";
  home.stateVersion = "26.05";

  # minimal example
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:
{
  imports = [
	../../modules/home/zsh.nix
	../../modules/home/wezterm.nix
  ];
  home.username = "wumingshi";
  home.homeDirectory = "/home/wumingshi";

  # Keep this at the version you first set up HM on this machine
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Example packages
  home.packages = with pkgs; [
	qbittorrent discord spotify
  ];
}


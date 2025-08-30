{ config, pkgs, ... }:
{
  imports = [
	../../modules/user/zsh.nix
	../../modules/user/wezterm.nix
  ];
  home.username = "wumingshi";
  home.homeDirectory = "/home/wumingshi";

  # Keep this at the version you first set up HM on this machine
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Example packages
  home.packages = with pkgs; [
    qbittorrent discord spotify obsidian
  ];
  services.syncthing.enable = true;
}


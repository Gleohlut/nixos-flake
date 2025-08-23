{ config, pkgs, ... }:
{
  # Default apps
  environment.systemPackages = with pkgs; [
  neovim wget curl libnotify swaynotificationcenter feh fuzzel alacritty tree vlc libreoffice-fresh nwg-look pavucontrol unp
  ];
  programs.zsh.enable = true;

  # Thunar and its services
  programs.thunar.enable = true;
  services = {
    udisks2.enable = true;   # auto-mounting via thunar-volman
    gvfs.enable = true;   # trash, network mounts, device integration
    tumbler.enable = true;   # thumbnails
  };

  # Flatpak
  services.flatpak.enable = true;
}

{ config, pkgs, lib, ... }:
{
  # Use a display manager to properly start the session. UWSM isn't supported
  services.displayManager.gdm.enable = true;
  
  # Enable Niri
  programs.niri.enable = true;
  
  # Status bar
  programs.waybar = {
  	enable = true;
  	systemd.target = "graphical-session.target";
  };
  
  # Waybar fix for clickable audio module
  systemd.user.services.waybar.path = [ pkgs.pavucontrol ];
  
  environment.systemPackages = lib.mkMerge [
  # Xwayland support for Niri
  (with pkgs; [ xwayland-satellite ])
  # KDE Polkit Agent
  (with pkgs; [ kdePackages.polkit-kde-agent-1 ])
  # Background image
  (with pkgs; [ hyprpaper ])
  ];

  # Lockscreen app
  programs.hyprlock.enable = true;

  # Portals
  xdg.portal = {
  enable = true;
  # simplest way to silence the 1.17+ warning and be compatible
  config.common.default = "gnome";
  # backends to install
  extraPortals = [
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk
  ];
  # optional but handy for “xdg-open”
  xdgOpenUsePortal = true;
  };
}

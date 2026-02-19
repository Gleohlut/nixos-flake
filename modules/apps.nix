{ pkgs, ... }:
{
  # Default apps
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    tree
    # Secure Boot
    sbctl
    lon
    # Clipboard
    wl-clipboard
    # Notifications
    libnotify
    swaynotificationcenter
    # Sound
    pavucontrol
    # Fonts
    font-manager
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  # Thunar and its services
  programs.thunar.enable = true;
  services = {
    udisks2.enable = true; # auto-mounting via thunar-volman
    gvfs.enable = true; # trash, network mounts, device integration
    tumbler.enable = true; # thumbnails
  };

  # Flatpak
  services.flatpak.enable = true;

  # Swap on zram
  zramSwap = {
    enable = true;
    memoryPercent = 25;
    algorithm = "zstd";
    priority = 100;
  };

  # Default desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
}

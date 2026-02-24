{ pkgs, ... }:
{
  # Default apps
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    # Security
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
    gcr
    libsecret
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

  # Provides org.freedesktop.secrets via D-Bus service definitions + daemon
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  # Optional GUI to inspect/manage the keyring
  programs.seahorse.enable = true;
}

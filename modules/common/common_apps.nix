{ pkgs, ... }:
{
  # Default apps
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    # Secure boot
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
}

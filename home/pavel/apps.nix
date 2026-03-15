{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Archives
    unp
    unzip
    unrar
    zip
    # File explorer
    yazi
    # Editor
    neovim
    # Multimedia
    feh
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    # Encryption
    cryfs
    fuse3
    sirikali
    # Secrets
    sops
    age
    # Scanner
    naps2
    # Screenshots
    grim
    slurp
    jq
    # Finder/For Neovim
    gcc
    fzf
    ripgrep
    fd
    poppler
    ffmpeg
    resvg
    imagemagick
    # Compositor-related
    waybar
    hyprlock
    swaylock
    rofi
  ];
}

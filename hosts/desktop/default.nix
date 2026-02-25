{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    ../../modules/desktop
  ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Host name
  networking.hostName = "desktop";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Time zone.
  time.timeZone = "Asia/Jakarta";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Host specific apps
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  # User account and shell. Don't forget to set a password with ‘passwd’.
  users.users.pavel = {
    isNormalUser = true;
    description = "Pavel";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "storage"
      "lp"
      "scanner"
      "fuse"
      "libvirtd"
      "kvm"
    ];
  };
  programs.zsh.enable = true;

  users.users.vanessa = {
    isNormalUser = true;
    description = "Vanessa";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "audio"
      "video"
      "storage"
      "lp"
      "scanner"
    ];
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.blex-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      material-design-icons
      font-awesome
    ];

    fontconfig = {
      enable = true;

      # Set IBM Plex Mono as the default monospace font
      defaultFonts = {
        monospace = [
          "BlexMono Nerd Font Mono"
          "JetBrainsMono Nerd Font"
        ];
        sansSerif = [
          "Noto Sans"
        ];
        serif = [
          "Noto Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  services.fwupd.enable = true;
  system.stateVersion = "26.05";
}

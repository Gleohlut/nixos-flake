{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system/niri.nix
      ../../modules/system/default-system-apps.nix
      ../../modules/system/gaming.nix
      ../../modules/system/printing.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "L480"; # Define your hostname.
    # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wumingshi = {
    isNormalUser = true;
    description = "wumingshi";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "storage" "lp" ];
    packages = with pkgs; [];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  # Video
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
	mesa
    	intel-media-driver   # VA-API hardware video decode/encode
    	intel-vaapi-driver   # legacy, some apps still use this
    	libvdpau-va-gl       # VDPAU wrapper on top of VA-API
    ];
  };

  # Sound
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  
  # Fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      ibm-plex
      font-awesome
      material-design-icons
      noto-fonts
      noto-fonts-emoji
    ];

    fontconfig = {
      enable = true;

      # Set IBM Plex Mono as the default monospace font
      defaultFonts = {
        monospace = [ "IBM Plex Mono" ];
        sansSerif = [ "IBM Plex Sans" "Noto Sans" ];
        serif     = [ "IBM Plex Serif" "Noto Serif" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };

  # Swap on zram
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
    priority = 100;
  };




  system.stateVersion = "25.05";

}

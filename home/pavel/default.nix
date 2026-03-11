{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    hypr = "hypr";
    niri = "niri";
    swaylock = "swaylock";
  };
in
{
  imports = [
    ./apps.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./sops.nix
    ./neovim.nix
    ./wezterm.nix
    ./gaming.nix
    ./rclone.nix
    ./yazi.nix
  ];
  home.username = "pavel";
  home.homeDirectory = "/home/pavel";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
    PROTON_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1"; # Electron/Chromium on Wayland
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
  }) configs;

  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    settings.options.urAccepted = -1;
  };

  # Keyring
  services.gnome-keyring = {
    enable = true;
    # Avoid it messing with SSH agent; you only need secrets.
    components = [ "secrets" ];
  };

  # VM boilerplate
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  # Turn off niri flake config
  programs.niri.config = null;
}

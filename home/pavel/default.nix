{
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    hypr = "hypr";
  };
in
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./yazi.nix
    ./sops.nix
    ./neovim.nix
    ./wezterm.nix
    ./gaming.nix
    ./hyprland.nix
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

  services.syncthing.enable = true;

  home.packages = with pkgs; [
    unp
    unzip
    neovim
    feh
    cryfs
    fuse3
    sirikali
    qbittorrent
    sops
    age
    naps2
    grim
    slurp
    jq
    gcc
    fzf
    ripgrep
    fd
    poppler
    ffmpeg
    resvg
    imagemagick
    zoxide
  ];
  programs.rofi.enable = true;
}

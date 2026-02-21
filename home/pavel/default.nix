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
    ./rclone.nix
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
    # Archives
    unp
    unzip
    unrar
    zip
    # Editor
    neovim
    # Image viewer
    feh
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    # Encryption
    cryfs
    fuse3
    sirikali
    # Torrent
    qbittorrent
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
    # Better cd
    zoxide
  ];
  programs.rofi.enable = true;

  services.gnome-keyring = {
    enable = true;
    # Avoid it messing with SSH agent; you only need secrets.
    components = [ "secrets" ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    systemd.enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
    extraConfig = builtins.readFile ../../config/hypr/hyprland.conf;
  };
  programs.hyprlock = {
    enable = true;

    settings = {
      "$font" = "Monospace";

      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 1, 1, 0, 0"
        ];
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = [
        {
          # omit monitor to apply to all monitors
          path = "screenshot";
          blur_passes = 3;
        }
      ];

      "input-field" = [
        {
          size = "20%, 5%";
          outline_thickness = 3;

          inner_color = "rgba(0, 0, 0, 0.0)";
          outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";

          font_color = "rgb(143, 143, 143)";
          fade_on_empty = false;
          rounding = 15;

          font_family = "$font";
          placeholder_text = "Input password...";
          fail_text = "$PAMFAIL";

          dots_spacing = 0.3;

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # TIME
        {
          text = "$TIME";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        # DATE
        {
          text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }

        # LAYOUT
        {
          text = "$LAYOUT[en,ru]";
          font_size = 24;
          onclick = "hyprctl switchxkblayout all next";
          position = "250, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    systemd.enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
    extraConfig = builtins.readFile ../../config/hypr/hyprland.conf;
  };
}

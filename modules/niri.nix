{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Make pkgs.niri-unstable come from niri-flake,
  # and pkgs.xwayland-satellite come from the xwayland-satellite flake.
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.xwayland-satellite.overlays.default
  ];

  # niri from the flake overlay (latest main = "unstable" in that flake)
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # xwayland-satellite from flake overlay
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "xwayland-satellite";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.xwayland-satellite} :0";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

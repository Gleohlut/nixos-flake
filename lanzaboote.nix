{ pkgs, lib, ... }:
let
  sources = import ./lon.nix;
  lanzaboote = import sources.lanzaboote { inherit pkgs; };
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

  environment.systemPackages = [ pkgs.sbctl ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";

    # New machine workflow
    autoGenerateKeys.enable = true;

    autoEnrollKeys = {
      enable = true;
      includeMicrosoftKeys = true; # avoids OptionROM boot issues
      autoReboot = true; # optional; reboots after preparing enrollment
    };
  };
}

# modules/system/printing.nix
{ pkgs, ... }:
{
  # CUPS print server
  services.printing.enable = true;

  # Prefer driverless IPP (AirPrint/IPP Everywhere)
  services.printing.drivers = [ pkgs.cups-filters ];

  # GUI tool (optional)
  environment.systemPackages = with pkgs; [ system-config-printer ];

  # Network discovery (Bonjour/mDNS)
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
  };

  # If you ever connect the printer by USB, this makes many HPs show up as IPP-over-USB:
  services.ipp-usb.enable = true;

  # (Optional) Scanning support — uncomment if your model has a scanner:
  # hardware.sane.enable = true;
  # hardware.sane.extraBackends = [ pkgs.hplip ];

  # (Only if some HP tools/plugins are needed)
  # services.printing.drivers = [ pkgs.hplipWithPlugin ];
  # environment.systemPackages = with pkgs; [ hplip ];
}


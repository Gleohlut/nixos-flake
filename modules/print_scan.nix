{ pkgs, ... }:
{
  # CUPS print server
  services.printing.enable = true;
  # Network discovery (Bonjour/mDNS)
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
  };

  # Prefer driverless IPP (AirPrint/IPP Everywhere)
  services.printing.drivers = [ pkgs.cups-filters ];

  # For scanning
  hardware.sane.enable = true;
  environment.systemPackages = with pkgs; [ sane-backends ];
}

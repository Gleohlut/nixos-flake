{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

  virtualisation.libvirtd.qemu = {
    runAsRoot = false;

    swtpm.enable = true; # vTPM
    ovmf = {
      enable = true; # UEFI firmware
      packages = [ pkgs.OVMFFull.fd ];
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  environment.systemPackages = with pkgs; [
    virtio-win
  ];
}

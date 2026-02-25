{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    runAsRoot = false;
    # Windows 11 vTPM support (TPM 2.0 device in virt-manager)
    swtpm.enable = true;
  };

  programs.virt-manager.enable = true;
  security.polkit.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = with pkgs; [
    virtio-win
    swtpm
  ];
}

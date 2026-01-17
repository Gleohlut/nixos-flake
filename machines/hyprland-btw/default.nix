{ inputs, self, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self; };
  modules = [
    ../../hosts/L480
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l480
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.pavel = import ../../home/pavel;
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit inputs self; };
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    }
  ];
}

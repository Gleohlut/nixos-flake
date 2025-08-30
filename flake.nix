{
  description = "NixOS flake (nixos-unstable) with integrated Home Manager";

  inputs = {
  # Unstable NixOS
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  # Unstable Home Manager
  home-manager.url = "github:nix-community/home-manager";

  # Home Manager packages follow the system
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    host   = "L480";
  in {
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./system/L480/base.nix

        # Keep flakes enabled declaratively
        ({ ... }: {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
        })

        # Home Manager as a NixOS module
        home-manager.nixosModules.default

        # Your HM config lives inside this flake
        ({ ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.wumingshi = import ./user/wumingshi/home.nix;
        })
      ];
    };
  };
}

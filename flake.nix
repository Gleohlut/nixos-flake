{
  description = "NixOS flake (nixos-unstable) with integrated Home Manager";

  inputs = {
    # Rolling channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager following unstable nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    host   = "L480";
  in {
    nixosConfigurations.L480 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/L480/base.nix

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

          home-manager.users.wumingshi = import ./home/wumingshi/home.nix;
        })
      ];
    };
  };
}


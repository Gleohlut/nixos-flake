{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      yazi,
      sops-nix,
      ...
    }:
    {
      nixosConfigurations = {
        hyprland-btw = (import ./machines/hyprland-btw) { inherit inputs self; };
      };
    };
}

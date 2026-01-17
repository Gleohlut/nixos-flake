{ config, ... }:
{
  sops = {
    age.keyFile = "/home/pavel/.config/sops/age/keys.txt"; # must have no password :contentReference[oaicite:3]{index=3}
    defaultSopsFile = ../../secrets/home.yaml;

    secrets = {
      github_pat = { };
    };
    templates."nix-access-tokens.conf".content = ''
      access-tokens = github.com=${config.sops.placeholder.github_pat}
    '';
  };
  xdg.configFile."nix/nix.conf".text = ''
    !include ${config.sops.templates."nix-access-tokens.conf".path}
  '';
}

{ config, lib, ... }:
{
  sops = {
    age.keyFile = "/home/pavel/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/home.yaml;

    secrets = {
      github_pat = { };

      # Write GitHub SSH keys from SOPS into ~/.ssh/
      github_ssh_private_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_github";
        mode = "0600";
      };

      github_ssh_public_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_github.pub";
        mode = "0644";
      };
    };

    templates."nix-access-tokens.conf".content = ''
      access-tokens = github.com=${config.sops.placeholder.github_pat}
    '';
  };

  # Ensure ~/.ssh exists and has correct permissions
  home.activation.ensureSshDir = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
  '';

  # User-level nix config includes the rendered token file
  xdg.configFile."nix/nix.conf".text = ''
    !include ${config.sops.templates."nix-access-tokens.conf".path}
  '';
}

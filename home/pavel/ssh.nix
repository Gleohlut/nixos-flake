{ ... }:
{
  programs.ssh = {
    enable = true;

    # Stop Home Manager from adding hidden defaults.
    enableDefaultConfig = false;

    matchBlocks = {
      # Old default values (make them explicit so future HM changes won't affect you)
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      # GitHub-specific settings
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_github";

        # Override the global default for this host:
        addKeysToAgent = "yes";
      };
    };
  };

  # Optional: keep an agent running in your user session (recommended)
  services.ssh-agent.enable = true;
}

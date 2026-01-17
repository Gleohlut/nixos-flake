{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = {
      ll = "ls -alF";
      nr = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hyprland-btw";
    };
    initContent = "
    PROMPT='%~ % '
    ";
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "zoxide"
      ];
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';
  };
  home.packages = with pkgs; [
    git
    zoxide
  ];
}

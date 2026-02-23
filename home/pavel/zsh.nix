{ ... }:
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
  };
}

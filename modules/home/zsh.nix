{ config, lib, pkgs, ... }:
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
    };
    initContent = "
    PROMPT='%~ % '
    ";
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "zoxide" ];
    };
  };
  home.packages = with pkgs; [
	git zoxide
  ];

}

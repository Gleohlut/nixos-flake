{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [
      luajit
      tree-sitter
      gcc
      fzf
      ripgrep
      fd
      # LSP
      lua-language-server
      nixd
      # Formatters
      stylua
      tombi
      prettier
      nixfmt
    ];
  };
}

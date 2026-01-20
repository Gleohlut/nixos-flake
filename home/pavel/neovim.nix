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
      # LSP
      lua-language-server
      nixd
      # Formatters
      stylua # Lua
      tombi
      prettier # HTML, CSS, JavaScript
      nixfmt # Nix
    ];
  };
}

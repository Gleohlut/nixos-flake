{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
}

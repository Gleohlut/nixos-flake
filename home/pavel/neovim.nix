{ pkgs, ... }:
{
  home.packages = with pkgs; [
    luajit
    tree-sitter
    # LSP
    lua-language-server # LUA
    nixd # Nix
    # Formatters
    stylua # Lua
    tombi # TOML
    prettier # HTML, CSS, JavaScript
    nixfmt # Nix
    kdlfmt
  ];
}

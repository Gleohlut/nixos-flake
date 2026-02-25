{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    opacity.terminal = 0.8;
    fonts = {
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "BlexMono Nerd Font Mono";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}

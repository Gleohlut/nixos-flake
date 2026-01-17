{ inputs, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}
      -- Appearance
      config.color_scheme = 'GruvboxDarkHard'
      config.window_background_opacity = 0.6
      config.window_decorations = "RESIZE"
      config.enable_tab_bar = true
      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }
      -- Font
      config.font = wezterm.font("BlexMono Nerd Font Mono")
      config.font_size = 16
      config.line_height = 1.2
      -- Cursor
      config.animation_fps = 1
      config.cursor_blink_ease_in = 'Constant'
      config.cursor_blink_ease_out = 'Constant'
      -- Misc
      config.window_close_confirmation = "AlwaysPrompt"
      config.enable_wayland = true
      config.scrollback_lines = 10000
      -- Config auto reload
      config.automatically_reload_config = true

      return config
    '';
  };
}

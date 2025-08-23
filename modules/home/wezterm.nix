{ config, lib, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_wayland = true
-- Font settings
config.font = wezterm.font("IBM Plex Mono")
config.font_size = 14
config.line_height = 1.2

-- Colors
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.8

-- Miscellaneous
config.max_fps = 120

return config

    '';
  };
}

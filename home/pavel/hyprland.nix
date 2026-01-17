{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ hyprpaper ];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/nixos-dotfiles/home/pavel/Wallpapers/wallhaven-og3wv9.png";
          fit_mode = "cover";
        }
      ];
    };
  };
  programs.rofi.enable = true;
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 4;
        blur_size = 4;
      };
      input-field = {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "<i>Password...</i>";
        shadow_passes = 2;
      };
      label = {
        monitor = "";
        text = "Hi there, $USER";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 25;
        font_family = "Noto Sans";

        position = "0, 80";
        halign = "center";
        valign = "center";
      };
    };
  };
}

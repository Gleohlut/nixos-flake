{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        blur = true;
        startup_mode = "Maximized";
        decorations = "None";
        dynamic_padding = false;
      };
      scrolling.history = 10000;
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };
  };
}

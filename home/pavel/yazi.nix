{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
    settings = {
      log.enabled = false;
      mgr = {
        ratio = [
          2
          4
          4
        ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dirs_first = true;
        sort_translit = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 10;
        mouse_events = [
          "click"
          "scroll"
        ];
        title_format = "{cwd}";
      };
      preview = {
        wrap = "no";
        tab_size = 2;
        image_filter = "nearest";
        image_quality = 90;
        ueberzug_scale = 1;
      };
    };
  };
}

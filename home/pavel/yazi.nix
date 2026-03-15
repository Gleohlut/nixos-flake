{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";
    settings = {
      mgr = {
        show_hidden = false;
        ratio = [
          2
          4
          4
        ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;
        linemode = "owner";
        show_symlink = true;
        scrolloff = 10;
      };
      preview = {
        wrap = "no";
        image_delay = 100;
        image_filter = "nearest";
        image_quality = 90;
      };
    };
  };
}

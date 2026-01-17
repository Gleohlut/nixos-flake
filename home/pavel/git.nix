{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Gleohlut";
        email = "166930736+Gleohlut@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";

      alias = {
        st = "status";
        lg = "log --oneline --graph --decorate";
      };
    };
  };
}

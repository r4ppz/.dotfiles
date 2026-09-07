{ dotfilesPath, ... }:

let
  sessionVars = {
    DOTFILES = dotfilesPath;

    EDITOR = "nvim";
    VISUAL = "nvim";
    SYSTEMD_EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    BROWSER = "brave-origin";
  };
in
{
  home.sessionVariables = sessionVars;
  systemd.user.sessionVariables = sessionVars;
}

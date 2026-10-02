{ dotfilesPath, pkgs, ... }:

let
  sessionVars = {
    DOTFILES = dotfilesPath;
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";

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

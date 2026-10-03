{
  config,
  dotfilesPath,
  pkgs,
  ...
}:

let
  sessionVars = {
    DOTFILES = dotfilesPath;
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";

    EDITOR = "nvim";
    VISUAL = "nvim";
    SYSTEMD_EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    BROWSER = "brave-origin";

    PI_CODING_AGENT_DIR = "${config.xdg.configHome}/pi/agent";
  };
in
{
  xdg.enable = true;
  home.sessionVariables = sessionVars;
  systemd.user.sessionVariables = sessionVars;
}

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

    PNPM_HOME = "${config.xdg.dataHome}/pnpm";
    NPM_CONFIG_PREFIX = "${config.xdg.dataHome}/npm";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    BUN_INSTALL_CACHE_DIR = "${config.home.homeDirectory}/.bun/install/cache";
    GOPATH = "${config.home.homeDirectory}/.go";

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

  home.sessionPath = [
    "${sessionVars.PNPM_HOME}/bin"
    "${sessionVars.BUN_INSTALL}/bin"
    "${sessionVars.GOPATH}/bin"
    "${sessionVars.NPM_CONFIG_PREFIX}/bin"

    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"

    "${dotfilesPath}/scripts/bin"
  ];
}

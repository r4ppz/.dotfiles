{ pkgs, configDir, ... }:

{
  home.packages = [ pkgs.kitty ];

  xdg.configFile."kitty".source = configDir + "/kitty";
}

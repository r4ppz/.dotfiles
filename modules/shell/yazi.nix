{ pkgs, configDir, ... }:

{
  home.packages = [ pkgs.yazi ];

  xdg.configFile."yazi".source = configDir + "/yazi";
}

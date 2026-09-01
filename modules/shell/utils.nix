{ pkgs, configDir, ... }:

{
  home.packages = with pkgs; [
    atuin
    gdu
    pgcli
  ];

  xdg.configFile."atuin".source = configDir + "/atuin";
  xdg.configFile."gdu".source = configDir + "/gdu";
  xdg.configFile."pgcli".source = configDir + "/pgcli";
}

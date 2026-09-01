{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprsunset ];

  services.hyprsunset = {
    enable = true;
    systemdTarget = "hyprland.target";
  };
}

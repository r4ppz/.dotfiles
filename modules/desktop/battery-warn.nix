{ pkgs, scriptDir, ... }:

let
  myScripts = import scriptDir { inherit pkgs; };
in
{
  systemd.user.services.battery-warn = {
    Unit = {
      Description = "Battery Level Monitor";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${myScripts.battery-warn}/bin/battery-warn";
      Restart = "always";
      RestartSec = "10s";
    };
    Install.WantedBy = [ "hyprland.target" ];
  };
}

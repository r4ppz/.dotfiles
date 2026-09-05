{ pkgs, scriptDir, ... }:

let
  myScripts = import scriptDir { inherit pkgs; };
in
{
  home.packages = [ pkgs.swaynotificationcenter ];

  services.blueman-applet = {
    enable = true;
    systemdTargets = [ "hyprland.target" ];
  };

  systemd.user.services = {
    blueman-applet = {
      Unit.PartOf = [ "hyprland.target" ];
      Install.WantedBy = [ "hyprland.target" ];
    };

    network-manager-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        PartOf = [ "hyprland.target" ];
        After = [ "hyprland.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    swaync = {
      Unit = {
        Description = "Swaync notification daemon";
        PartOf = [ "hyprland.target" ];
        After = [ "hyprland.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    battery-warn = {
      Unit = {
        Description = "Battery Level Monitor";
        After = [ "hyprland.target" ];
        PartOf = [ "hyprland.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${myScripts.battery-warn}/bin/battery-warn";
        Restart = "always";
        RestartSec = "10s";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };
  };
}

{
  pkgs,
  configDir,
  inputs,
  ...
}:

let
  myScripts = import ../../script { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprsunset

    bitwarden-desktop
    thunar

    rofi
    swaynotificationcenter
    networkmanagerapplet
    blueman
    gsimplecal
  ];

  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar;
    systemd = {
      enable = true;
      targets = [ "hyprland.target" ];
    };
  };

  services.hyprpaper = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  services.hypridle = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  services.swaync.enable = true;
  services.blueman-applet.enable = true;

  systemd.user.targets.hyprland = {
    Unit = {
      Description = "User services specific to Hyprland session";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services = {
    swaync = {
      Unit.PartOf = [ "hyprland.target" ];
      Install.WantedBy = [ "hyprland.target" ];
    };

    blueman-applet = {
      Unit.PartOf = [ "hyprland.target" ];
      Install.WantedBy = [ "hyprland.target" ];
    };

    hyprsunset = {
      Unit = {
        Description = "Hyprland blue light filter";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    hyprpolkitagent = {
      Unit = {
        Description = "Hyprland Polkit Authentication Agent";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    network-manager-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    battery-warn = {
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
  };

  xdg.configFile."hypr".source = configDir + "/hypr";
  xdg.configFile."waybar".source = configDir + "/waybar";
  xdg.configFile."swaync".source = configDir + "/swaync";
  xdg.configFile."rofi".source = configDir + "/rofi";
}

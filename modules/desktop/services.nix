{ pkgs, scriptDir, ... }:

let
  myScripts = pkgs.callPackage scriptDir { };
in
{
  services = {
    hypridle = {
      enable = true;
    };

    hyprpaper = {
      enable = true;
    };

    hyprsunset = {
      enable = true;
    };
  };

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
      PartOf = [ "hyprland-session.target" ];
      After = [ "hyprland-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  wayland.windowManager.hyprland = {
    enable = false; # see modules/home/links.nix:17
    systemd.enable = true;
  };

  services = {
    ssh-agent = {
      enable = true;
    };

    blueman-applet = {
      enable = true;
      systemdTargets = [ "hyprland-session.target" ];
    };
  };

  systemd.user.services = {
    blueman-applet = {
      Unit.PartOf = [ "hyprland-session.target" ];
      Install.WantedBy = [ "hyprland-session.target" ];
    };

    network-manager-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };

    swaync = {
      Unit = {
        Description = "Swaync notification daemon";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };

    battery-warn = {
      Unit = {
        Description = "Battery Level Monitor";
        After = [ "hyprland-session.target" ];
        PartOf = [ "hyprland-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${myScripts.battery-warn}/bin/battery-warn";
        Restart = "always";
        RestartSec = "10s";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
      };
    };

    waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}

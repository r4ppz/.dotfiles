{
  pkgs,
  ...
}:

let
  hyprService = {
    enable = true;
    systemdTarget = "hyprland.target";
  };
in
{
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

  home.packages = with pkgs; [
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
  ];

  services = {
    hypridle = hyprService;
    hyprpaper = hyprService;
    hyprsunset = hyprService;
  };

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
      PartOf = [ "hyprland.target" ];
      After = [ "hyprland.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "hyprland.target" ];
  };
}

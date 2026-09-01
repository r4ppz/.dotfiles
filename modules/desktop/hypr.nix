{
  configDir,
  pkgs,
  ...
}: {
  xdg.configFile."hypr".source = configDir + "/hypr";

  systemd.user.targets.hyprland = {
    Unit = {
      Description = "User services specific to Hyprland session";
      BindsTo = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  home.packages = [
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.hyprpaper
    pkgs.hyprsunset
  ];

  services.hypridle = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  services.hyprpaper = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  services.hyprsunset = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
      PartOf = ["hyprland.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
    Install.WantedBy = ["hyprland.target"];
  };

  programs.obs-studio.enable = true;
  wayland.windowManager.hyprland.xdph.settings = {
    screencopy = {
      max_fps = 60;
      cursor_mode = 2;
    };
  };
}

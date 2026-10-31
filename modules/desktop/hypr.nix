{
  pkgs,
  ...
}:

let
  hyprService = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
in
{
  home.packages = with pkgs; [
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    hyprpicker
  ];

  services = {
    hypridle = hyprService;
    hyprpaper = hyprService;
    hyprsunset = hyprService;
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
    enable = false;
    systemd.enable = false;

    xdph.settings = {
      screencopy = {
        max_fps = 60;
        cursor_mode = 2;
        allow_token_by_default = true;
      };
    };
  };
}

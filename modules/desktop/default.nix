{ configDir, ... }:

{
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
    ./waybar.nix
    ./swaync.nix
    ./blueman.nix
    ./network-manager.nix
    ./hyprpolkit.nix
    ./battery-warn.nix
    ./rofi.nix
    ./packages.nix
  ];

  xdg.configFile."hypr".source = configDir + "/hypr";

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
}

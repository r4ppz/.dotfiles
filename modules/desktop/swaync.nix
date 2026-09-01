{
  pkgs,
  configDir,
  ...
}: {
  home.packages = [pkgs.swaynotificationcenter];

  services.swaync.enable = true;

  systemd.user.services.swaync = {
    Unit.PartOf = ["hyprland.target"];
    Install.WantedBy = ["hyprland.target"];
  };

  xdg.configFile."swaync".source = configDir + "/swaync";
}

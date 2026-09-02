{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.swaynotificationcenter ];

  systemd.user.services.swaync = {
    Unit.PartOf = [ "hyprland.target" ];
    Install.WantedBy = [ "hyprland.target" ];
  };
}

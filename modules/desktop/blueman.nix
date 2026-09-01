{...}: {
  services.blueman-applet = {
    enable = true;
    systemdTargets = ["hyprland.target"];
  };

  systemd.user.services.blueman-applet = {
    Unit.PartOf = ["hyprland.target"];
    Install.WantedBy = ["hyprland.target"];
  };
}

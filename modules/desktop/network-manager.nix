{pkgs, ...}: {
  systemd.user.services.network-manager-applet = {
    Unit = {
      Description = "NetworkManager Applet";
      PartOf = ["hyprland.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      Restart = "on-failure";
    };
    Install.WantedBy = ["hyprland.target"];
  };
}

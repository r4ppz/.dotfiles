{ pkgs, ... }:

{
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
      package = pkgs.waybar;
      systemd = {
        enable = true;
        targets = [ "hyprland.target" ];
      };
    };

    brave-origin = {
      enable = true;
      commandLineArgs = [
        "--disable-features=WaylandWpColorManagerV1"
        "--ozone-platform-hint=auto"
      ];
    };
  };
}

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
  };
}

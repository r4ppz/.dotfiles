{ inputs, pkgs, ... }:

{
  imports = [ inputs.helium-browser.homeModules.default ];

  programs = {
    obs-studio = {
      enable = true;
    };

    waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
      systemd = {
        enable = true;
        targets = [ "hyprland.target" ];
      };
    };

    helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=auto"
      ];
    };
  };

}

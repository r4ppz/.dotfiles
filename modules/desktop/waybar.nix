{
  pkgs,
  inputs,
  ...
}:

{
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
    systemd = {
      enable = true;
      targets = [ "hyprland.target" ];
    };
  };
}

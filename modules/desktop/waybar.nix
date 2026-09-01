{ pkgs, inputs, configDir, ... }:

{
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar;
    systemd = {
      enable = true;
      targets = [ "hyprland.target" ];
    };
  };

  xdg.configFile."waybar".source = configDir + "/waybar";
}

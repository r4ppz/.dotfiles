{
  pkgs,
  configDir,
  ...
}: {
  home.packages = [pkgs.rofi];

  xdg.configFile."rofi".source = configDir + "/rofi";
}

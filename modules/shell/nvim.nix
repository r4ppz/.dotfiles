{ pkgs, configDir, ... }:

{
  home.packages = [ pkgs.neovim ];

  xdg.configFile."nvim".source = configDir + "/nvim";
}

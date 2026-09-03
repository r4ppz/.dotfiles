{ username, ... }:
{
  imports = [
    ./modules/styling
    ./modules/desktop
    ./modules/shell
    ./modules/dev
    ./modules/home
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}

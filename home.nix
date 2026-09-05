{ username, ... }:
{
  imports = [
    ./modules/styling
    ./modules/desktop
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

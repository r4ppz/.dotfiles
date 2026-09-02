{
  imports = [
    ./modules/styling
    ./modules/desktop
    ./modules/shell
    ./modules/dev
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  home.username = "r4ppz";
  home.homeDirectory = "/home/r4ppz";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

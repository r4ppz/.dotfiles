{
  imports = [
    ./modules/styling
    ./modules/desktop
    ./modules/shell
    ./modules/dev
    ./modules/dotfiles.nix
  ];

  home = {
    username = "r4ppz";
    homeDirectory = "/home/r4ppz";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}

{
  imports = [
    ./modules/styling
    ./modules/desktop
    ./modules/shell
    ./modules/shell/git.nix
    ./modules/dev
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "r4ppz";
  home.homeDirectory = "/home/r4ppz";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

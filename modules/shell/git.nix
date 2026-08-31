{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker
  ];

  xdg.configFile."lazygit".source = ../../config/lazygit;
  xdg.configFile."lazydocker".source = ../../config/lazydocker;

  home.file.".gitconfig".source = ../../config/git/.gitconfig;
}

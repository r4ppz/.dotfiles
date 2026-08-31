{ pkgs, configDir, ... }:

{
  home.packages = with pkgs; [
    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker
  ];

  xdg.configFile."lazygit".source = configDir + "/lazygit";
  xdg.configFile."lazydocker".source = configDir + "/lazydocker";

  home.file.".gitconfig".source = configDir + "/git/.gitconfig";
}

{ pkgs, configDir, ... }:

{
  home.packages = [ pkgs.tmux ];

  home.file.".tmux.conf".source = configDir + "/tmux/.tmux.conf";
}

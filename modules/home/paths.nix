{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.sessionVariables = {
    DOTFILES = dotfiles;
    NH_FLAKE = dotfiles;
  };

  systemd.user.sessionVariables = {
    DOTFILES = dotfiles;
    NH_FLAKE = dotfiles;
  };
}

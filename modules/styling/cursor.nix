{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.hackneyed;
    name = "Hackneyed";
    size = 24;
  };
}

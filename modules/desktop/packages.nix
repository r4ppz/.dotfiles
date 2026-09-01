{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave-origin
    bitwarden-desktop
    thunar
    gsimplecal
    impala
    bluetui
  ];
}

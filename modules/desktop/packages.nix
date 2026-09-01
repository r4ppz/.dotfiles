{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    thunar
    gsimplecal
    impala
    bluetui
  ];
}

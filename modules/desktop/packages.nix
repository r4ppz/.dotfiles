{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    libnotify
    brave-origin
    bitwarden-desktop
    playerctl
    thunar
    gsimplecal
    impala
    bluetui
    imv
    rofi
  ];
}

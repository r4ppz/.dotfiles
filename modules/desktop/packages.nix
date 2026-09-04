{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulseaudio
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

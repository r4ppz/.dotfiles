{ pkgs, ... }:

{
  home.packages = with pkgs; [
    trash-cli
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
    mpv
    rofi
  ];
}

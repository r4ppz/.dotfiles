{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    brave-origin
    gsimplecal

    obs-cmd
    trash-cli
    pulseaudio
    wl-clipboard
    libnotify
    playerctl
    impala
    bluetui
    imv
    mpv
    rofi
    grim
    slurp
    tesseract
    imagemagick
    bc
    bluetuith
    cliamp
  ];
}

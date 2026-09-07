{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
    bitwarden-desktop
    brave-origin
    gsimplecal
    onlyoffice-desktopeditors

    obs-cmd
    trash-cli
    pulseaudio
    wl-clipboard
    libnotify
    playerctl
    brightnessctl
    impala
    bluetui
    imv
    mpv
    rofi
    grim
    slurp
    bluetuith
    cliamp
  ];
}

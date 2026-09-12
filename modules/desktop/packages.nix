{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.okular
    quickshell
    bitwarden-desktop
    brave-origin
    gsimplecal
    onlyoffice-desktopeditors

    imv
    mpv
    rofi
    grim
    slurp

    impala
    bluetui
    cliamp

    obs-cmd
    trash-cli
    pulseaudio
    wl-clipboard
    libnotify
    playerctl
    brightnessctl
  ];
}

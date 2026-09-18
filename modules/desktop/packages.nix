{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.okular
    quickshell
    bitwarden-desktop
    brave-origin
    gsimplecal
    onlyoffice-desktopeditors
    foliate
    papers
    gnome-disk-utility
    obsidian

    imv
    mpv
    rofi
    grim
    slurp

    circumflex
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

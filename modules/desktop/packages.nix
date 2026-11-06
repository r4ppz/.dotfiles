{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tetro-tui # < game :0

    chromium
    helium
    firefox

    kdePackages.okular
    quickshell
    bitwarden-desktop
    gsimplecal
    onlyoffice-desktopeditors
    gnome-disk-utility
    obsidian
    obs-studio
    goldendict-ng
    qbittorrent
    authenticator
    bottles
    krita

    vlc
    imv
    mpv
    rofi
    grim
    slurp

    bookokrat
    circumflex
    bulletty
    impala
    bluetui
    cliamp
    concord-tui

    pinentry-tty
    rbw
    ollama
    obs-cmd
    trash-cli
    pulseaudio
    wl-clipboard
    libnotify
    playerctl
    brightnessctl
  ];
}

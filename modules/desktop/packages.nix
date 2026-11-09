{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    hyprpicker

    tetro-tui # < game :0

    chromium
    helium
    firefox

    swaynotificationcenter
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
    bottles

    vlc
    imv
    mpv
    rofi
    grim
    slurp

    bookokrat
    circumflex
    newsboat
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

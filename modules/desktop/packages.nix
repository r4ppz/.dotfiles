{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Hypr stuff
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    hyprpicker

    tetro-tui # < game :0

    # Browsers
    helium
    firefox
    vivaldi

    # GUI apps
    kdePackages.okular
    bitwarden-desktop
    gsimplecal
    onlyoffice-desktopeditors
    gnome-disk-utility
    obs-studio
    goldendict-ng
    qbittorrent
    bottles
    vlc
    imv
    mpv

    # Layers
    rofi
    grim
    slurp
    swaynotificationcenter
    quickshell

    # TUIs
    bookokrat
    circumflex
    newsboat
    impala
    bluetui
    cliamp
    concord-tui

    # CLIs
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

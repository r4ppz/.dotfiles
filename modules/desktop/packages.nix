{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cisco-packet-tracer_9

    helium
    firefox
    brave-origin

    kdePackages.okular
    quickshell
    bitwarden-desktop
    gsimplecal
    onlyoffice-desktopeditors
    gnome-disk-utility
    obsidian
    obs-studio
    goldendict-ng

    imv
    mpv
    rofi
    grim
    slurp

    bookokrat
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

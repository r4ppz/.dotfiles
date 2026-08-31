{ config, pkgs, ... }:

{
  home.username = "r4ppz";
  home.homeDirectory = "/home/r4ppz";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    home-manager

    hypridle
    hyprlock
    hyprpaper
    hyprsunset

    # brave-origin
    bitwarden-desktop

    delta
    diff-so-fancy
    difftastic
    git
    neovim
    kitty
    lazygit
    lazydocker
    btop
    fastfetch
    fzf
    fd
    waybar
    yazi
    thunar
    zoxide
    rofi
    tmux
    swaynotificationcenter
    eza
    opencode
    glow
    bluetuith
    cliamp
    networkmanagerapplet
    blueman

    nodejs
    go
    gcc
    python3
    rustup

    curl
    vim
    unzip
    wget

    nixfmt

    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum

    nwg-look
    gruvbox-plus-icons

    hackneyed
    bibata-cursors
  ];
}

{ config, pkgs, ... }:

{
  home.username = "r4ppz";
  home.homeDirectory = "/home/r4ppz";

  home.stateVersion = "26.05";

  fonts.fontconfig = {
    enable = true;

    antialiasing = true;
    hinting = "full";
    subpixelRendering = "rgb";

    defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  home.packages = with pkgs; [
    # Hyprland
    hypridle
    hyprlock
    hyprpaper
    hyprsunset

    # Desktop applications
    bitwarden-desktop
    thunar

    # Fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Terminal / CLI
    kitty
    neovim
    btop
    fastfetch
    fzf
    fd
    yazi
    zoxide
    eza
    glow
    bluetuith
    cliamp
    tmux

    # Git
    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker

    # Desktop / Wayland
    waybar
    rofi
    swaynotificationcenter
    networkmanagerapplet
    blueman

    # Development
    nodejs
    go
    gcc
    python3
    rustup

    # Utilities
    curl
    vim
    unzip
    wget
    nixfmt

    # Theming
    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum
    nwg-look
    gruvbox-plus-icons
    hackneyed
    bibata-cursors
  ];

  # Application configuration
  xdg.configFile."hypr".source = ./config/hypr;
  xdg.configFile."kitty".source = ./config/kitty;
  xdg.configFile."lazydocker".source = ./config/lazydocker;
  xdg.configFile."lazygit".source = ./config/lazygit;
  xdg.configFile."opencode".source = ./config/opencode;
  xdg.configFile."rofi".source = ./config/rofi;
  xdg.configFile."swaync".source = ./config/swaync;
  xdg.configFile."waybar".source = ./config/waybar;
  xdg.configFile."yazi".source = ./config/yazi;
  xdg.configFile."atuin".source = ./config/atuin;

  home.file.".tmux.conf".source = ./config/tmux/.tmux.conf;

  programs.home-manager.enable = true;
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    qt6Packages.qt6ct
    nwg-look
    hackneyed
    bibata-cursors

    gruvbox-gtk-theme
    gruvbox-kvantum
    gruvbox-plus-icons
    libsForQt5.qtstyleplugin-kvantum # For Qt5 apps
    kdePackages.qtstyleplugin-kvantum # For Qt6 apps
  ];

  fonts.fontconfig = {
    enable = true;

    antialiasing = true;
    hinting = "medium";
    subpixelRendering = "rgb";

    defaultFonts = {
      serif = [ "JetBrains Mono" ];
      sansSerif = [ "JetBrains Mono" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.hackneyed;
    name = "Hackneyed";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    font = {
      name = "JetBrainsMono Nerd Font Semi-Bold";
      size = 9;
    };
    cursorTheme = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
    };
  };

  # Qt / Kvantum Configuration
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.gruvbox-kvantum;
    };
  };
}

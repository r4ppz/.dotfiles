{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum
    nwg-look
    gruvbox-plus-icons
    hackneyed
    bibata-cursors
  ];

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

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.hackneyed;
    name = "Hackneyed";
    size = 24;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
    };
  };
}

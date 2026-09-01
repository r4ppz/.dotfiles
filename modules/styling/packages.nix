{pkgs, ...}: {
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    nwg-look
    hackneyed
    bibata-cursors

    gruvbox-gtk-theme
    gruvbox-plus-icons
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];
}

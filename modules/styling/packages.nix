{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nwg-look
    gruvbox-kvantum

    libsForQt5.qtstyleplugin-kvantum
  ];
}

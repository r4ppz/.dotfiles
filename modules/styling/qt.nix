{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.gruvbox-kvantum;
    };
  };
}

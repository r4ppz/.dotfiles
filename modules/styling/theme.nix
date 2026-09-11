{ pkgs, ... }:

let
  # Colloid Gruvbox Theme
  colloidGruvbox = pkgs.colloid-gtk-theme.override {
    colorVariants = [ "dark" ];
    themeVariants = [ "default" ];
    tweaks = [
      "gruvbox"
      "rimless"
    ];
  };

  # Shared font rendering tweaks
  xftConfig = {
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
  };
in
{
  home.packages = with pkgs; [
    nwg-look
    gruvbox-kvantum
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Colloid-Dark-Gruvbox";
      package = colloidGruvbox;
    };

    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 10;
    };

    cursorTheme = {
      name = "Hackneyed";
      package = pkgs.hackneyed;
      size = 24;
    };

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

    gtk3.extraConfig = xftConfig;
    gtk4.extraConfig = xftConfig;
  };

  xdg = {
    configFile = {
      "gtk-4.0/assets".source = "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/assets";

      "gtk-4.0/gtk.css".source = "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/gtk.css";

      "gtk-4.0/gtk-dark.css".source =
        "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/gtk-dark.css";

      "Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";

      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Gruvbox-Dark-Brown
      '';
    };
  };
}

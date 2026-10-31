{ pkgs, ... }:

let
  # Colloid Gruvbox GTK Theme
  colloidGruvbox = pkgs.colloid-gtk-theme.override {
    colorVariants = [ "dark" ];
    themeVariants = [ "default" ];
    tweaks = [
      "gruvbox"
      "rimless"
    ];
  };

  gruvboxKvantum = pkgs.gruvbox-kvantum.override {
    variant = "Gruvbox-Dark-Blue";
  };

  # Common GTK opts
  gtkCommonConfig = {
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
    gtk-application-prefer-dark-theme = 1;
  };

  qtctAppearance = {
    Appearance = {
      style = "kvantum";
      icon_theme = "Gruvbox-Plus-Dark";
      standard_dialogs = "xdgdesktopportal";
    };
    Fonts = {
      general = ''"Inter,10"'';
      fixed = ''"Inter,10"'';
    };
  };
in
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Colloid-Dark-Gruvbox";
    };
  };

  home.packages = with pkgs; [
    nwg-look
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    glib
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
    qt5ctSettings = qtctAppearance;
    qt6ctSettings = qtctAppearance;
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

    gtk3.extraConfig = gtkCommonConfig;
    gtk4.extraConfig = gtkCommonConfig;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${colloidGruvbox}/share/themes/Colloid-Dark-Gruvbox/gtk-4.0/gtk-dark.css";
  };

  qt.kvantum = {
    enable = true;
    themes = [ gruvboxKvantum ];
    settings.General.theme = "Gruvbox-Dark-Blue";
  };
}

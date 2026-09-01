{pkgs, ...}: {
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
      size = 10;
    };
    cursorTheme = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
    };
  };
}

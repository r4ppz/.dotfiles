_:

{
  xdg.desktopEntries.nvim = {
    name = "Neovim";
    genericName = "Text Editor";
    exec = "kitty -e nvim %F";
    terminal = false;
    icon = "nvim";
    type = "Application";
    categories = [
      "Utility"
      "TextEditor"
    ];
    mimeType = [
      "text/plain"
      "text/markdown"
      "text/x-c"
      "text/x-c++"
      "application/json"
      "application/x-shellscript"
    ];
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];

      "text/markdown" = [ "nvim.desktop" ];
      "text/plain" = [ "nvim.desktop" ];

      "x-scheme-handler/bitwarden" = [ "bitwarden.desktop" ];
      "x-scheme-handler/mailto" = [ "helium.desktop" ];

      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];

      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
    };
  };
}

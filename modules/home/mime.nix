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
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];

      # Text / code
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "text/x-c" = [ "nvim.desktop" ];
      "text/x-c++" = [ "nvim.desktop" ];
      "text/x-python" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "application/x-shellscript" = [ "nvim.desktop" ];
      "application/x-yaml" = [ "nvim.desktop" ];
      "application/toml" = [ "nvim.desktop" ];

      # Scheme handlers
      "x-scheme-handler/bitwarden" = [ "bitwarden.desktop" ];
      "x-scheme-handler/mailto" = [ "com.brave.Origin.desktop" ];
      "x-scheme-handler/http" = [ "com.brave.Origin.desktop" ];
      "x-scheme-handler/https" = [ "com.brave.Origin.desktop" ];

      # Video
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];

      # Images
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];

      # Documents
      "application/pdf" = [ "okularApplication_pdf.desktop" ];
      "application/epub+zip" = [ "okularApplication_pdf.desktop" ];

      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        "onlyoffice-desktopeditors.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
        "onlyoffice-desktopeditors.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        "onlyoffice-desktopeditors.desktop"
      ];
      "application/vnd.oasis.opendocument.text" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.oasis.opendocument.spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
    };
  };
}

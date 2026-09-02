{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;

    antialiasing = true;
    hinting = "medium";
    subpixelRendering = "rgb";

    defaultFonts = {
      serif = ["JetBrains Mono"];
      sansSerif = ["JetBrains Mono"];
      monospace = ["JetBrains Mono"];
      emoji = ["Noto Color Emoji"];
    };
  };
}

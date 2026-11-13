_:

{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
      };
    };

    waybar = {
      enable = true;
      systemd.enable = true;
    };

    brave-origin = {
      enable = true;
      extensions = [
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium C
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      ];
      commandLineArgs = [
        "--disable-features=WaylandWpColorManagerV1"
        "--ozone-platform-hint=auto"
        "--enable-features=OverlayScrollbar,RootScrollbarFollowsBrowserTheme"
        "--disable-smooth-scrolling"
        "--force-prefers-reduced-motion"
      ];
    };
  };
}

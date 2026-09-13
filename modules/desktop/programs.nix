{ inputs, pkgs, ... }:

{
  imports = [ inputs.helium-browser.homeModules.default ];

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
        "late.sh" = {
          HostName = "late.sh";
          User = "r4ppz";
          IdentityFile = "~/.ssh/id_late_sh_ed25519";
          IdentitiesOnly = true;
        };
      };
    };

    obs-studio = {
      enable = true;
    };

    waybar = {
      enable = true;
      package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
      systemd = {
        enable = true;
        targets = [ "hyprland.target" ];
      };
    };

    helium = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
  };

}

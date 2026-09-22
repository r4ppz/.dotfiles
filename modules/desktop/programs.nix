{ inputs, pkgs, ... }:

{
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

    waybar = {
      enable = true;
      package = pkgs.waybar;
      systemd = {
        enable = true;
        targets = [ "hyprland.target" ];
      };
    };
  };
}

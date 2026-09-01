{configDir, ...}: {
  imports = [
    ./hypr.nix
    ./waybar.nix
    ./swaync.nix
    ./blueman.nix
    ./network-manager.nix
    ./battery-warn.nix
    ./rofi.nix
    ./packages.nix
  ];
}

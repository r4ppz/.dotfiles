{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    go
    gcc
    python3
    rustup
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    go
    gcc
    python3
    rustup
    zig
    tree-sitter

    # DAP
    delve
  ];
}

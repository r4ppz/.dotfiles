{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.packages = with pkgs; [
    nodejs
    pnpm
    go
    gcc
    python3
    rustup
    zig
    tree-sitter
    gnumake

    # DAP
    delve
  ];
}

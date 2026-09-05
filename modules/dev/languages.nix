{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.packages = with pkgs; [
    nodejs
    go
    gcc
    python3
    rustup
    zig

    # smh
    pnpm
    tree-sitter
    gnumake
    delve
  ];
}

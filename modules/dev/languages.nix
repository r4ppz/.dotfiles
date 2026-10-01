{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.packages = with pkgs; [
    python3
    nodejs
    go
    gcc
    zig
    luajit

    pipx
    rustc
    cargo
    clippy
    rustfmt

    # smh
    pnpm
    tree-sitter
    gnumake
    delve
    maven
    lombok
    cmake
  ];
}

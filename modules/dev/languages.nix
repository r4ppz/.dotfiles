{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        cryptography
      ]
    ))

    nodejs
    go
    gcc
    zig
    luajit

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
  ];
}

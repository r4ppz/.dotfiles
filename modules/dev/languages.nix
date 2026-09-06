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
    rustup
    zig

    # smh
    pnpm
    tree-sitter
    gnumake
    delve
    maven
    lombok
  ];
}

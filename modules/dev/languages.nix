{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        requests
        beautifulsoup4
        flask
        websockets
        cryptography
        pycryptodome
        sympy
        z3-solver
        pillow
        scapy
        pandas
        numpy
        ropper
        tqdm
      ]
    ))

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

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
        pandas
        numpy
        tqdm
      ]
    ))

    # compilers/runtimes
    nodejs
    bun
    go
    gcc
    zig
    luajit
    rustc

    # package managers
    # and build stuff
    pipx
    cargo
    pnpm
    gnumake
    maven
    cmake

    # libs
    lombok
    luajitPackages.tiktoken_core
    tree-sitter

    # debug
    delve
  ];
}

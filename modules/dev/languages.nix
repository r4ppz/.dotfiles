{pkgs, ...}: {
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

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Languages
    nodejs
    go
    gcc
    python3
    rustup
    zig
    tree-sitter

    # LSP Servers
    vscode-langservers-extracted
    yaml-language-server
    marksman
    typescript-language-server
    emmet-ls
    astro-language-server
    svelte-language-server
    prisma-language-server
    intelephense
    nil
    jdt-language-server
    docker-compose-language-service
    dockerfile-language-server
    lemminx
    sqls
    gopls
    qt6.qtdeclarative
    taplo
    lua-language-server
    pyright
    bash-language-server
    hyprls
    clang-tools
    zls

    # DAP
    delve

    # Formatters
    prettierd
    stylua
    shfmt
    black
    google-java-format

    # Linters
    eslint_d
    checkmake
  ];
}

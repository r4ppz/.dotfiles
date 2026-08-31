{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Frontend
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

    # Backend
    jdt-language-server
    docker-compose-language-service
    dockerfile-language-server
    lemminx
    sqls
    gopls

    # General
    qt6.qtdeclarative
    taplo
    lua-language-server
    pyright
    bash-language-server
    hyprls
    clang-tools
    zls
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    kitty
    tmux
    yazi
    opencode
    pgcli
    sqlite

    btop
    fastfetch
    fzf
    fd
    zoxide
    eza
    ripgrep
    atuin
    gdu
    dua
    rsync
    glow
    bat

    git-lfs
    gh
    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker

    curl
    wget
    openssl
    jq
    tesseract
    imagemagick
    bc
    resvg
    chafa
    pkg-config

    p7zip
    unzip
    zip
    unrar
  ];
}

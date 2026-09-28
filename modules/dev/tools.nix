{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sqlitebrowser

    neovim
    kitty
    tmux
    yazi
    pgcli
    sqlite

    claude-code
    opencode
    crush
    kiro
    codex

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
    speedtest-go
    tlrc
    yt-dlp

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

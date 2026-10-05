{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    kitty
    tmux
    yazi

    claude-code
    opencode
    crush
    codex
    pi-coding-agent

    lnav
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

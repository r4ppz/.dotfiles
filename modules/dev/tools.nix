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

    tailspin
    lnav

    pgcli
    btop
    fastfetch
    fzf
    atuin
    gdu

    curl
    wget
    openssl
    fd
    jq
    bc

    ast-grep
    ripgrep
    rsync
    tlrc
    yt-dlp
    dua
    glow
    bat
    zoxide
    eza

    exiftool
    xxd
    cyberchef
    poppler-utils
    exiftool

    sqlite
    tesseract
    pkg-config
    imagemagick

    p7zip
    unzip
    zip
    unrar

    gh
    git
    delta
    git-filter-repo
    diff-so-fancy
    difftastic
    lazygit
    lazydocker
    git-lfs
  ];
}

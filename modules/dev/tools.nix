{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    kitty
    tmux
    yazi

    opencode
    pi-coding-agent

    tailspin
    lnav

    fastfetch
    fzf
    atuin
    gdu
    witr
    lazydocker

    curl
    wget
    openssl
    fd
    jq
    bc
    fswatch

    nvd
    nix-tree

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

    file
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
    git-lfs
  ];
}

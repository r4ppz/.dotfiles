{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim

    btop
    fastfetch
    fzf
    fd
    zoxide
    eza
    glow
    bluetuith
    cliamp
    tmux
    yazi
    opencode
    kitty

    ripgrep
    curl
    vim
    unzip
    wget
    grim
    slurp
    tesseract
    libnotify
    bc

    atuin
    gdu
    pgcli

    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker
  ];
}

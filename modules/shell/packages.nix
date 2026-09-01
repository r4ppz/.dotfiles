{ pkgs, ... }:

{
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
    nixfmt
    grim

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

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    kitty
    tmux
    yazi
    opencode
    pgcli

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
    curl
    wget
    unzip
    rsync
    bc
    glow

    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker
  ];
}

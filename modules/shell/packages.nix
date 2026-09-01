{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    fastfetch
    fzf
    fd
    zoxide
    eza
    glow
    bluetuith
    cliamp

    ripgrep
    curl
    vim
    unzip
    wget
    nixfmt
    grim
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prettierd
    stylua
    shfmt
    black
    google-java-format
    alejandra
  ];
}

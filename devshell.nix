{ pkgs }:

{
  default = pkgs.mkShell {
    packages = with pkgs; [
      nixfmt
      shellcheck
      shfmt
      statix
      stylua
    ];
  };
}

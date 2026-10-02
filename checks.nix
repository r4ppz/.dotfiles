{ pkgs, source }:

{
  format =
    pkgs.runCommand "dotfiles-format"
      {
        nativeBuildInputs = with pkgs; [
          nixfmt
          shfmt
          stylua
        ];
      }
      ''
        cd ${source}
        nixfmt --check $(find . -type f -name '*.nix')
        stylua --check configs/nvim configs/hypr
        shfmt --diff $(find scripts configs -type f -name '*.sh')
        touch $out
      '';

  lint =
    pkgs.runCommand "dotfiles-lint"
      {
        nativeBuildInputs = with pkgs; [
          shellcheck
          statix
        ];
      }
      ''
        cd ${source}
        shellcheck $(find scripts configs -type f -name '*.sh')
        statix check
        touch $out
      '';
}

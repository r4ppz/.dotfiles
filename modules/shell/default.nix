{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    neovim
    btop
    fastfetch
    fzf
    fd
    yazi
    zoxide
    eza
    glow
    bluetuith
    cliamp
    tmux
    opencode

    curl
    vim
    unzip
    wget
    nixfmt
  ];

  xdg.configFile."kitty".source = ../../config/kitty;
  xdg.configFile."yazi".source = ../../config/yazi;
  xdg.configFile."atuin".source = ../../config/atuin;
  xdg.configFile."gdu".source = ../../config/gdu;
  xdg.configFile."nvim".source = ../../config/nvim;
  xdg.configFile."pgcli".source = ../../config/pgcli;

  xdg.configFile."opencode/opencode.json".source = ../../config/opencode/opencode.json;
  xdg.configFile."opencode/tui.json".source = ../../config/opencode/tui.json;
  xdg.configFile."opencode/AGENTS.md".source = ../../config/opencode/AGENTS.md;

  home.file.".tmux.conf".source = ../../config/tmux/.tmux.conf;

  home.file.".zshrc".source = ../../config/zsh/.zshrc;
  home.file.".zprofile".source = ../../config/zsh/.zprofile;
  home.file.".zsh_plugins.txt".source = ../../config/zsh/.zsh_plugins.txt;
}

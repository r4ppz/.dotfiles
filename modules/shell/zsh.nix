{ configDir, ... }:

{
  home.file.".tmux.conf".source = configDir + "/tmux/.tmux.conf";

  home.file.".zshrc".source = configDir + "/zsh/.zshrc";
  home.file.".zprofile".source = configDir + "/zsh/.zprofile";
  home.file.".zsh_plugins.txt".source = configDir + "/zsh/.zsh_plugins.txt";
}

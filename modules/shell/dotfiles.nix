{configDir, ...}: {
  home.file.".gitconfig".source = configDir + "/git/.gitconfig";
  home.file.".tmux.conf".source = configDir + "/tmux/.tmux.conf";

  xdg.configFile."lazygit".source = configDir + "/lazygit";
  xdg.configFile."lazydocker".source = configDir + "/lazydocker";
  xdg.configFile."nvim".source = configDir + "/nvim";
  xdg.configFile."yazi".source = configDir + "/yazi";
  xdg.configFile."kitty".source = configDir + "/kitty";

  xdg.configFile."atuin".source = configDir + "/atuin";
  xdg.configFile."gdu".source = configDir + "/gdu";
  xdg.configFile."pgcli".source = configDir + "/pgcli";

  xdg.configFile."opencode/opencode.json".source = configDir + "/opencode/opencode.json";
  xdg.configFile."opencode/tui.json".source = configDir + "/opencode/tui.json";
  xdg.configFile."opencode/AGENTS.md".source = configDir + "/opencode/AGENTS.md";

  home.file.".zshrc".source = configDir + "/zsh/.zshrc";
  home.file.".zprofile".source = configDir + "/zsh/.zprofile";
  home.file.".zsh_plugins.txt".source = configDir + "/zsh/.zsh_plugins.txt";
}

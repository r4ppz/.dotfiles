{ configDir, ... }:

{
  home.file = {
    ".gitconfig".source = configDir + "/git/.gitconfig";
    ".tmux.conf".source = configDir + "/tmux/.tmux.conf";
    ".zshrc".source = configDir + "/zsh/.zshrc";
    ".zprofile".source = configDir + "/zsh/.zprofile";
    ".zsh_plugins.txt".source = configDir + "/zsh/.zsh_plugins.txt";
  };

  xdg.configFile = {
    "lazygit".source = configDir + "/lazygit";
    "lazydocker".source = configDir + "/lazydocker";
    "nvim".source = configDir + "/nvim";
    "yazi".source = configDir + "/yazi";
    "kitty".source = configDir + "/kitty";

    "atuin".source = configDir + "/atuin";
    "gdu".source = configDir + "/gdu";
    "pgcli".source = configDir + "/pgcli";

    "opencode/opencode.json".source = configDir + "/opencode/opencode.json";
    "opencode/tui.json".source = configDir + "/opencode/tui.json";
    "opencode/AGENTS.md".source = configDir + "/opencode/AGENTS.md";
  };
}

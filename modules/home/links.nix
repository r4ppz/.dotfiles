{ config, ... }:

let
  configDir = "${config.home.sessionVariables.DOTFILES}/configs";
in
{
  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/git/.gitconfig";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/tmux/.tmux.conf";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zsh/.zshrc";
    ".zprofile".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zsh/.zprofile";
    ".zsh_plugins.txt".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zsh/.zsh_plugins.txt";
  };

  xdg.configFile = {
    "hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr";
      recursive = true;
    };

    "rofi".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/rofi";
    "btop".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/btop";
    "swaync".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/swaync";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/waybar";

    "lazygit".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/lazygit";
    "lazydocker".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/lazydocker";

    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/nvim";
    "yazi".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/yazi";
    "kitty".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/kitty";

    "atuin".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/atuin";
    "gdu".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/gdu";
    "pgcli".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/pgcli";

    "bookokrat".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/bookokrat";

    "opencode".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/opencode";
  };
}

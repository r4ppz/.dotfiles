{ pkgs, configDir, ... }:

{
  home.packages = [ pkgs.opencode ];

  xdg.configFile."opencode/opencode.json".source = configDir + "/opencode/opencode.json";
  xdg.configFile."opencode/tui.json".source = configDir + "/opencode/tui.json";
  xdg.configFile."opencode/AGENTS.md".source = configDir + "/opencode/AGENTS.md";
}

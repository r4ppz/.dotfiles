{ pkgs }:

{
  battery-warn = pkgs.writeShellApplication {
    name = "battery-warn";

    runtimeInputs = with pkgs; [
      libnotify
      coreutils
    ];

    text = builtins.readFile ./bin/battery-warn.sh;
  };
}

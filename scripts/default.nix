{
  writeShellApplication,
  libnotify,
  coreutils,
}:

{
  battery-warn = writeShellApplication {
    name = "battery-warn";

    runtimeInputs = [
      libnotify
      coreutils
    ];

    text = builtins.readFile ./bin/battery-warn.sh;
  };
}

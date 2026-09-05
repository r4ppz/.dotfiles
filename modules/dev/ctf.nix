{ pkgs, ... }:

{
  home.packages = with pkgs; [
    exiftool
    binwalk
    steghide
    zsteg
    sleuthkit
    hexdump
    xxd
    file
    cfr

    radare2
    pwntools
    cyberchef
    bitwise
  ];
}

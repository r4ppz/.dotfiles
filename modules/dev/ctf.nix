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
    jq
    file
  ];
}

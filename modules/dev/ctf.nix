{ pkgs, ... }:

{
  home.packages = with pkgs; [
    exiftool
    binwalk
    steghide
    zsteg
    sleuthkit
    gzip
    hexdump
    xxd
    jq
    file
  ];
}

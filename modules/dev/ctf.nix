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
    hashid
    hexedit

    radare2
    pwntools
    cyberchef
    bitwise

    hey
    ffuf
    apacheHttpd
    wrk

    binutils
    foremost
    scalpel
    pngcheck
    zbar
    sox
    tshark
    tcpflow
    volatility3
    poppler-utils
    oletools
    john
    fcrackzip
    hashcat

  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # File identification, metadata, and inspection
    file # Identify file types
    exiftool # Read and write file metadata
    hexdump # Display binary data as hexadecimal
    xxd # Hex dump and reverse hex conversion
    hexedit # Interactive hexadecimal editor
    binutils # Binary utilities such as strings, objdump, and readelf
    bitwise # Bitwise and numeric conversion calculator

    # File carving and steganography
    binwalk # Analyze and extract embedded firmware data
    foremost # Recover files using file headers
    scalpel # Fast file-carving utility
    steghide # Hide and extract data in image or audio files
    zsteg # Detect steganography in PNG and BMP images
    pngcheck # Validate and inspect PNG files
    zbar # Read barcodes and QR codes

    # Reverse engineering and binary analysis
    radare2 # Reverse-engineering framework
    cfr # Java class-file decompiler
    sleuthkit # Digital forensics and filesystem analysis tools
    volatility3 # Memory forensics framework

    # Password recovery and hash analysis
    hashid # Identify password-hash formats
    john # John the Ripper password cracker
    hashcat # GPU-accelerated password recovery
    fcrackzip # Crack password-protected ZIP archives

    # Web application and fuzzing tools
    burpsuite # Web application security testing proxy
    ffuf # Fast web fuzzing tool
    cyberchef # Browser-based data transformation toolkit

    # Exploit development and scripting
    pwntools # Python framework for exploit development
    hey # Command-line HTTP load generator

    # Web servers and performance testing
    apacheHttpd # Apache HTTP web server
    wrk # HTTP benchmarking tool

    # Network capture and traffic analysis
    tshark # Command-line Wireshark packet analyzer
    tcpflow # Capture and reconstruct TCP streams

    # Audio and document analysis
    sox # Command-line audio processing utility
    poppler-utils # PDF conversion and inspection tools
    oletools # Analyze Microsoft Office OLE and VBA files
  ];
}

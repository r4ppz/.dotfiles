{ pkgs, ... }:

# CTF tools

# Webtools:
# https://crackstation.net/
# https://cyberchef.org/
# https://dogbolt.org/
# https://www.aperisolve.com/
# https://stegotoolkit.com/steganography/binary-extractor
# https://safezipkit.com/analyze-zip
# https://ctfpal.com/

# sleuthkit basics:
# mmls   → "What partitions?"
# fsstat → "What filesystem?"
# fls    → "What files/directories?"
# icat   → "Give me this file's contents!"
# istat  → "What are this inode's metadata/timestamps?"
# blkls  → "Show unallocated blocks (potentially deleted data)"
# blkcat → "Show me this specific filesystem block"
# mactime → "Build a timeline from MAC timestamps"
# tsk_recover → "Recover files from the filesystem into a directory"

# mount the partition on host
# mount -o ro,loop,offset=$((<START>*512)) disk.img /mnt/ctf <- this is the location

# isolate the Linux partition as a raw image
# dd
# ├── if=      input file
# ├── of=      output file
# ├── bs=      size of each unit
# ├── skip=    how many input units to skip
# └── count=   how many units to copy
# Example:
# dd if=disko-2.dd of=linux_partition.img bs=512 skip=2048 count=51200
# from mmls
# ├── Start  → skip
# └── Length → count

# For timeline image thing
# fls -r -m / partition.img > body.txt
# mactime -b body.txt > timeline.txt

let
  stepic = pkgs.python3Packages.buildPythonPackage rec {
    pname = "stepic";
    version = "0.5.0";

    pyproject = true;

    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      hash = "sha256-zBwrL5SlyUkm/GAf7Qtw5yuIoJ5UuJDucCJkIVYRmHU=";
    };

    build-system = [
      pkgs.python3Packages.setuptools
    ];

    propagatedBuildInputs = [
      pkgs.python3Packages.pillow
    ];

    doCheck = false;
  };
in
{
  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        requests
        beautifulsoup4
        flask
        websockets
        cryptography
        pycryptodome
        sympy
        z3-solver
        pillow
        scapy
        pandas
        numpy
        ropper
        tqdm
      ]
    ))

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
    stepic # Python image steganography tool

    # Reverse engineering and binary analysis
    radare2 # Reverse-engineering framework
    cfr # Java class-file decompiler
    sleuthkit # Digital forensics and filesystem analysis tools
    # autopsy # GUI for The Sleuth Kit
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

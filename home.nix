{ pkgs, ... }:

let
  myScripts = import ./script { inherit pkgs; };
in
{
  home.username = "r4ppz";
  home.homeDirectory = "/home/r4ppz";

  home.stateVersion = "26.05";

  fonts.fontconfig = {
    enable = true;

    antialiasing = true;
    hinting = "full";
    subpixelRendering = "rgb";

    defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Modules with built-in systemd integration
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "hyprland.target" ];
    };
  };

  services.hyprpaper = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  services.hypridle = {
    enable = true;
    systemdTarget = "hyprland.target";
  };

  # Standard Home Manager service modules
  services.swaync.enable = true;
  services.blueman-applet.enable = true;

  # Custom Systemd Target
  systemd.user.targets.hyprland = {
    Unit = {
      Description = "User services specific to Hyprland session";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Custom Systemd Services & Overrides
  systemd.user.services = {
    # Appending unit targets to HM-managed services without lib.mkForce
    swaync = {
      Unit.PartOf = [ "hyprland.target" ];
      Install.WantedBy = [ "hyprland.target" ];
    };

    blueman-applet = {
      Unit.PartOf = [ "hyprland.target" ];
      Install.WantedBy = [ "hyprland.target" ];
    };

    # Full systemd definitions for applications without built-in HM systemd units
    hyprsunset = {
      Unit = {
        Description = "Hyprland blue light filter";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    hyprpolkitagent = {
      Unit = {
        Description = "Hyprland Polkit Authentication Agent";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    network-manager-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        PartOf = [ "hyprland.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };

    battery-warn = {
      Unit = {
        Description = "Battery Level Monitor";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${myScripts.battery-warn}/bin/battery-warn";
        Restart = "always";
        RestartSec = "10s";
      };
      Install.WantedBy = [ "hyprland.target" ];
    };
  };

  home.packages = with pkgs; [
    # Hyprland
    hypridle
    hyprlock
    hyprpaper
    hyprsunset

    # Desktop applications
    bitwarden-desktop
    thunar

    # Fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # Terminal / CLI
    kitty
    neovim
    btop
    fastfetch
    fzf
    fd
    yazi
    zoxide
    eza
    glow
    bluetuith
    cliamp
    tmux
    opencode

    # Git
    git
    delta
    diff-so-fancy
    difftastic
    lazygit
    lazydocker

    # Desktop / Wayland
    rofi
    swaynotificationcenter
    networkmanagerapplet
    blueman

    # Development
    nodejs
    go
    gcc
    python3
    rustup

    # Utilities
    curl
    vim
    unzip
    wget
    nixfmt

    # Theming
    qt6Packages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum
    nwg-look
    gruvbox-plus-icons
    hackneyed
    bibata-cursors
  ];

  # Application configuration
  xdg.configFile."hypr".source = ./config/hypr;
  xdg.configFile."kitty".source = ./config/kitty;
  xdg.configFile."lazydocker".source = ./config/lazydocker;
  xdg.configFile."lazygit".source = ./config/lazygit;
  xdg.configFile."rofi".source = ./config/rofi;
  xdg.configFile."swaync".source = ./config/swaync;
  xdg.configFile."waybar".source = ./config/waybar;
  xdg.configFile."yazi".source = ./config/yazi;
  xdg.configFile."atuin".source = ./config/atuin;
  xdg.configFile."gdu".source = ./config/gdu;
  xdg.configFile."nvim".source = ./config/nvim;
  xdg.configFile."pgcli".source = ./config/pgcli;

  xdg.configFile."opencode/opencode.json".source = ./config/opencode/opencode.json;
  xdg.configFile."opencode/tui.json".source = ./config/opencode/tui.json;
  xdg.configFile."opencode/AGENTS.md".source = ./config/opencode/AGENTS.md;

  home.file.".tmux.conf".source = ./config/tmux/.tmux.conf;

  home.file.".zshrc".source = ./config/zsh/.zshrc;
  home.file.".zprofile".source = ./config/zsh/.zprofile;
  home.file.".zsh_plugins.txt".source = ./config/zsh/.zsh_plugins.txt;

  home.file.".gitconfig".source = ./config/git/.gitconfig;

  programs.home-manager.enable = true;
}

{
  pkgs,
  username,
  ...
}:

let
  dotfilesPath = "/home/${username}/Nix-dotfiles";
in

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;

    kernelModules = [ "tcp_bbr" ];

    kernel.sysctl = {
      # ZRAM optimizations
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;

      # Network latency & throughput improvements (BBR + FQ)
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = false;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  fileSystems."/".options = [ "noatime" ];

  documentation.nixos.enable = false;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    max-jobs = "auto";
    cores = 0;
  };

  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    description = "John Rey Rabosa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "brave-origin";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:warping=1";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  programs = {
    ydotool = {
      enable = true;
      group = "input";
    };

    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };

    zsh.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    nh = {
      enable = true;
      flake = dotfilesPath;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };

  services = {
    thermald.enable = true;
    fstrim.enable = true;
    auto-cpufreq.enable = true;
    blueman.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = false;
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "esc";
              esc = "grave";
              grave = "home";
              # delete = "power";
              home = "power";
              rightalt = "leftmeta";
              kp8 = "up";
              kp5 = "down";
              kp4 = "left";
              kp6 = "right";
              # space = "overload(meta, space)";
            };
          };
        };
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}

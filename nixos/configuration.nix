{
  config,
  pkgs,
  username,
  dotfilesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    tmp.useTmpfs = true;
    initrd.systemd.enable = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;

    extraModulePackages = with config.boot.kernelPackages; [
      acer-wmi-battery
    ];

    kernelModules = [
      "tcp_bbr"
      "acer-wmi-battery"
    ];

    # Set the 80% charge limit automatically when the module loads
    extraModprobeConfig = ''
      options acer-wmi-battery enable_health_mode=1
    '';

    kernelParams = [ "intel_pstate=active" ];

    kernel.sysctl = {
      "vm.swappiness" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.page-cluster" = 0;

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

    enableAllFirmware = true;
  };

  fileSystems."/mnt/SHARED" = {
    device = "/dev/disk/by-uuid/2AFE9FF83A7A94B4";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=1000"
      "umask=0022"
      "noatime"
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=15s"
    ];
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    hostName = "nixos";
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  security = {
    rtkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("wheel") &&
            action.id.indexOf("org.freedesktop.login1.") === 0
          ) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  documentation.nixos.enable = false;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    max-jobs = "auto";
    cores = 0;
    warn-dirty = false;
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
      "docker"
      "libvirtd"
      "kvm"
      "video"
    ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SYSTEMD_EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:warping=1";
  };

  environment.systemPackages = with pkgs; [
    file-roller
    ffmpegthumbnailer
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    nh = {
      enable = true;
      flake = dotfilesPath;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };

    virt-manager.enable = true;
    dconf.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };

    xfconf.enable = true;
  };

  services = {
    dbus.implementation = "broker";
    gnome.gnome-keyring.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    tumbler.enable = true;
    gvfs.enable = true;

    irqbalance.enable = true;
    thermald.enable = true;
    fstrim.enable = true;

    logind.settings.Login = {
      HandlePowerKey = "ignore";
    };

    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "always";
          energy_performance_preference = "performance";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
          energy_performance_preference = "balance_power";
        };
      };
    };
    blueman.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = false;
      wireplumber.enable = true;
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
    udev.extraRules = ''
      SUBSYSTEM=="backlight", ACTION=="add", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
      SUBSYSTEM=="backlight", ACTION=="add", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    '';
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    spiceUSBRedirection.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
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

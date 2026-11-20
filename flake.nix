{
  description = "My system my rules!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-browser = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bookokrat = {
      url = "github:bugzmanov/bookokrat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      bookokrat,
      helium-browser,
      neovim-nightly-overlay,
      ...
    }@inputs:
    let
      username = "r4ppz";
      hostname = "nixos";
      dotfilesPath = "/home/${username}/.dotfiles";
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            username
            dotfilesPath
            hostname
            ;
        };
        modules = [
          {
            nixpkgs.overlays = [
              helium-browser.overlays.default
              neovim-nightly-overlay.overlays.default

              (final: prev: {
                waybar = prev.waybar.overrideAttrs (old: {
                  doCheck = false;
                  mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dtests=disabled" ];
                });

                # https://github.com/bugzmanov/bookokrat/releases/tag/v0.3.14
                bookokrat = bookokrat.packages.${prev.stdenv.hostPlatform.system}.default.overrideAttrs (old: rec {
                  version = "0.3.14";
                  src = prev.fetchFromGitHub {
                    owner = "bugzmanov";
                    repo = "bookokrat";
                    tag = "v${version}";
                    hash = "sha256-mnP7GChMKEvCGV+Gb0X8twx4w/IDChOtcLZBbrCDMJQ=";
                  };
                  doCheck = false;
                });

                # https://github.com/chojs23/concord/releases/tag/v2.7.1
                concord-tui = prev.concord-tui.overrideAttrs (old: rec {
                  version = "2.7.1";
                  src = prev.fetchFromGitHub {
                    owner = "chojs23";
                    repo = "concord";
                    tag = "v${version}";
                    hash = "sha256-DMbs4rfIIvmkw1DA81r3IAwlOafZHu+MeHhajgeIB/k=";
                  };
                  cargoHash = "sha256-5svgbFG/ErFBJJ9BqKZx0vAxotJi2nAxaKEa1IXfe8Y=";
                  doCheck = false;
                  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
                    prev.git
                    prev.cmake
                  ];
                });
              })
            ];
          }

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                configDir = ./configs;
                scriptDir = ./scripts;
                inherit inputs username dotfilesPath;
              };
              users.${username} = ./home.nix;
            };
          }
        ];
      };

      devShells = forAllSystems (
        system:
        import ./devshell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );

      checks = forAllSystems (
        system:
        import ./checks.nix {
          pkgs = nixpkgs.legacyPackages.${system};
          source = ./.;
        }
      );
    };
}

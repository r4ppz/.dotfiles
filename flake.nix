{
  description = "I'm going crazy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    waybar = {
      url = "github:Alexays/Waybar";
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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      bookokrat,
      waybar,
      helium-browser,
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
              waybar.overlays.default
              helium-browser.overlays.default

              (final: prev: {
                bookokrat = bookokrat.packages.${prev.stdenv.hostPlatform.system}.default;

                tmux = prev.tmux.overrideAttrs (old: rec {
                  version = "3.8";
                  src = prev.fetchFromGitHub {
                    owner = "tmux";
                    repo = "tmux";
                    tag = "${version}";
                    hash = "sha256-pv2wlr3coo+E0pfpb58giJJQn9PGgMFqtVA6nk+9JdE=";
                  };
                });

                concord-tui = prev.concord-tui.overrideAttrs (old: rec {
                  version = "2.6.1";
                  doCheck = false;
                  src = prev.fetchFromGitHub {
                    owner = "chojs23";
                    repo = "concord";
                    tag = "v${version}";
                    hash = "sha256-aNoU83FE/+nu9OUF2oIDmGzMAxPqhmuJn9HtpWd9NhA=";
                  };
                  cargoDeps = prev.rustPlatform.fetchCargoVendor {
                    inherit src;
                    hash = "sha256-P7p0SJM5WD3rw2BbayOqw2Hl61SDTo+bO755exztAA0=";
                  };
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

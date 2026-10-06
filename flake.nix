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
                tmux = prev.tmux.overrideAttrs (old: {
                  version = "3.8-rc3";
                  src = prev.fetchFromGitHub {
                    owner = "tmux";
                    repo = "tmux";
                    rev = "3.8-rc3";
                    hash = "sha256-dWUD62onx4cSwngtZTlF9pggA/9Z/Vmn77nD53luld0=";
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

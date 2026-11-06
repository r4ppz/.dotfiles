{
  description = "My system my rules!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    waybar = {
      url = "github:Alexays/Waybar/377f4cd4f9300c19d99e4c66b0cd1a2f4fd09870";
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
      waybar,
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
              waybar.overlays.default
              helium-browser.overlays.default
              neovim-nightly-overlay.overlays.default

              (final: prev: {
                waybar = prev.waybar.overrideAttrs (old: {
                  doCheck = false;
                  mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dtests=disabled" ];
                });

                bookokrat = bookokrat.packages.${prev.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
                  doCheck = false;
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

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

    # temp fix
    fix-opencode.url = "github:NixOS/nixpkgs/d4448fee6bab71511ac36747a98a2aad35544852";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      fix-opencode,
      bookokrat,
      waybar,
      helium-browser,
      ...
    }@inputs:
    let
      username = "r4ppz";
      dotfilesPath = "/home/${username}/.dotfiles";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username dotfilesPath; };
        modules = [
          {
            nixpkgs.overlays = [
              waybar.overlays.default
              helium-browser.overlays.default

              (final: prev: {
                opencode = fix-opencode.legacyPackages.${prev.stdenv.hostPlatform.system}.opencode;
                bookokrat = bookokrat.packages.${prev.stdenv.hostPlatform.system}.default;
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
    };
}

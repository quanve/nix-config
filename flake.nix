{
  description = "My multi-host NixOS + Home-Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;

      user = "quanve";

      myLib = {
        configBuilder = import ./lib/config-builder.nix { inherit lib; };
      };

      mkNixos =
        hostname: system: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs self user;
            libx = myLib;
          };

          modules = lib.flatten [
            {
              nixpkgs.overlays = [
                (import ./overlays)
              ];
            }

            ./hosts/common
            (./hosts + "/${hostname}")

            inputs.lanzaboote.nixosModules.lanzaboote

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";

                extraSpecialArgs = {
                  inherit inputs self user;
                  libx = myLib;
                };

                users.${user} = {
                  imports = [
                    ./home/common
                    ./home/users/${user}
                    (./home/users/${user}/host-specific + "/${hostname}")
                    inputs.caelestia-shell.homeManagerModules.default
                  ];
                  home.stateVersion = "25.05";
                };
              };
            }

            extraModules
          ];
        };

      treefmtEval = system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix;

      mkIso =
        variant:
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./iso/base.nix
            (./iso + "/${variant}.nix")
          ];
        }).config.system.build.isoImage;

    in
    {
      nixosConfigurations = {
        desktop = mkNixos "desktop" "x86_64-linux" [ ];
        test = mkNixos "test" "x86_64-linux" [ ];
      };

      packages.x86_64-linux = {
        iso-minimal = mkIso "minimal";
        iso-kde = mkIso "kde";
      };

      formatter.x86_64-linux = (treefmtEval "x86_64-linux").config.build.wrapper;

      checks.x86_64-linux = {
        formatting = (treefmtEval "x86_64-linux").config.build.check self;
        desktop = self.nixosConfigurations.desktop.config.system.build.toplevel;
      };
    };
}

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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      user = "quanve";

      myLib = {
        configBuilder = import ./lib/config-builder.nix { inherit lib; };
      };

      mkNixos = hostname: system: extraModules: nixpkgs.lib.nixosSystem {
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
              useGlobalPkgs       = true;
              useUserPackages     = true;
              backupFileExtension = "hm-bak";

              sharedModules = [
                inputs.nixvim.homeModules.nixvim
              ];

              extraSpecialArgs = {
                inherit inputs self user;
                libx = myLib;
              };

              users.${user} = {
                imports = [
                  ./home/common
                  ./home/users/${user}
                  (./home/users/${user}/host-specific + "/${hostname}")
                ];
                home.stateVersion = "25.05";
              };
            };
          }

          extraModules
        ];
      };

    in {
      nixosConfigurations = {
        desktop = mkNixos "desktop" "x86_64-linux" [];
        test   = mkNixos "test"   "x86_64-linux" [];
        # laptop  = mkNixos "laptop"  "x86_64-linux" [];
      };
    };
}

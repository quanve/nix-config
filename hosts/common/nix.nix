{ lib, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
      ];
      warn-dirty = lib.mkDefault false;
      substituters = lib.mkDefault [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = lib.mkDefault [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      max-jobs = lib.mkDefault "auto";
    };

    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    extraOptions = lib.mkDefault ''
      min-free = ${toString (512 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      fallback = true
      connect-timeout = 5
      log-lines = 25
    '';
  };

  nixpkgs.config = {
    allowUnfree = lib.mkDefault true;
  };
}

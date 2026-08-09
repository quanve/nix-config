{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs.nixfmt.enable = true;
  programs.nixfmt.package = pkgs.nixfmt;
}

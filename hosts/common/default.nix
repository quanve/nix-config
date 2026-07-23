{ config, pkgs, lib, ... }:

let
  systemModules = [
    "networking"
    "bootloader"
    "security"
    "nix"
  ];
in
{
  imports = map (module: ./${module}.nix) systemModules;

  system.stateVersion = lib.mkDefault "25.05";
}
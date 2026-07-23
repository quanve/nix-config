{ config, pkgs, inputs, ... }:

let
  systemModules = [
    "hardware-configuration"
    "virtualization"
    "bootloader"
    "networking"
    "packages"
    "hardware"
    "security"
    "desktop"
    "users"
    "fonts"
    "nix"
  ];
in
{
  imports = map (module: ./${module}.nix) systemModules;

  system.stateVersion = "25.05";
}

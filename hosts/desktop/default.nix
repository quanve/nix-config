{ ... }:
let
  systemModules = [
    "hardware-configuration"
    "virtualization"
    "bootloader"
    "networking"
    "packages"
    "hardware"
    "security"
    "vfio"
    "display"
    "apps"
    "services"
    "users"
    "fonts"
    "nix"
  ];
in
{
  imports = map (module: ./${module}.nix) systemModules;

  system.stateVersion = "25.05";
}

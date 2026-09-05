{ ... }:
let
  systemModules = [
    "hardware-configuration"
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
  ];
in
{
  imports = map (module: ./${module}.nix) systemModules;

  system.stateVersion = "25.05";
}

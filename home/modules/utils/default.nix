{ ... }:
let
  utilsModules = [
    "utilities-wayland"
    "utilities-system"
    "file-management"
    "utilities-x11"
    "utilities"
    "nixvim"
  ];
in
{
  imports = map (module: ./${module}.nix) utilsModules;
}

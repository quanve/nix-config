{ ... }:
let
  utilsModules = [
    "utilities-wayland"
    "utilities-system"
    "file-management"
    "utilities-x11"
    "utilities"
  ];
in
{
  imports = map (module: ./${module}.nix) utilsModules;
}

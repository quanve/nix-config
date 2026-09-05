{ ... }:
let
  coreModules = [
    "editors"
    "gnome"
  ];
in
{
  imports = map (module: ./${module}.nix) coreModules;
}

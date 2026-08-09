{ ... }:
let
  coreModules = [
    "terminal"
    "editors"
    "gnome"
  ];
in
{
  imports = map (module: ./${module}.nix) coreModules;
}

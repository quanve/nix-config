{ ... }:
let
  gamingModules = [
    "minecraft"
    "wine"
  ];
in
{
  imports = map (module: ./${module}.nix) gamingModules;
}

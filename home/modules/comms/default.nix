{ ... }:
let
  commsModules = [
    "telegram"
    "obsidian"
    "vesktop"
  ];
in
{
  imports = map (module: ./${module}.nix) commsModules;
}

{ ... }:
let
  commsModules = [
    "telegram"
    "obsidian"
    "discord"
  ];
in
{
  imports = map (module: ./${module}.nix) commsModules;
}

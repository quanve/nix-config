{ config, pkgs, inputs, ... }:

let
  devModules = [
    "reverse-engineering"
    "development"
    "vpn"
    "git"
  ];
in
{
  imports = map (module: ./${module}.nix) devModules;
}

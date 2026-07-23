{ config, pkgs, inputs, ... }:

let
  homeModules = [
    "desktop"
    "gaming"
    "utils"
    "comms"
    "core"
    "dev"
  ];
in
{
  imports = map (module: ./${module}) homeModules;
}

{ config, pkgs, inputs, ... }:
let
  enabledProfiles = [
    "niri/waybar"
    "river"
  ];

  profileImports = map (profile: ./profiles + "/${profile}") enabledProfiles;
in {
  imports = [
    ./profiles/shared/default.nix
  ] ++ profileImports;
}

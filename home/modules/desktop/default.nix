{ ... }:
let
  desktopModules = [
    "obs-studio"
    "firefox"
    "themes"
    "media"
    "hyprland"
    "caelestia-shell"
  ];
in
{
  imports = map (module: ./${module}.nix) desktopModules;
}

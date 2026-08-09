{ ... }:
let
  desktopModules = [
    "obs-studio"
    "firefox"
    "themes"
    "media"
  ];
in
{
  imports = map (module: ./${module}.nix) desktopModules;
}

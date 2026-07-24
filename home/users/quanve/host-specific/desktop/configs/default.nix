{ config, pkgs, inputs, libx, ... }:
{
  imports = [
    ./dunst.nix
    ./fuzzel.nix
    ./waybar.nix
  ];

  xdg.configFile = libx.configBuilder.make {
    niri = {
      path = ./niri;
      executable = [ "switch_wallpaper.sh" ];
    };
  };
}

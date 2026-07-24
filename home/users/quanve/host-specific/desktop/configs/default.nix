{ config, pkgs, inputs, libx, ... }:
{
  imports = [
    ./fuzzel.nix
    ./waybar.nix
    ./dunst.nix
    ./foot.nix
  ];

  xdg.configFile = libx.configBuilder.make {
    niri = {
      path = ./niri;
      executable = [ "switch_wallpaper.sh" ];
    };
  };
}

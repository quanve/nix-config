{ config, pkgs, inputs, ... }:
{
  imports = [
    ./dunst.nix
    ./fuzzel.nix
    ./waybar.nix
    ./niri.nix
  ];
}

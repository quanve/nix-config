{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    swaylock
    fuzzel
    waybar
    dunst
  ];
}

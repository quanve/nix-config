{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protonplus
    # portproton
    heroic
    wine
  ];
}

{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    openjdk25

  ];
}

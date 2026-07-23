{ config, lib, pkgs, libx, ... }:
{
  xdg.configFile = libx.configBuilder.make {
    kitty = ./configs/kitty;
    fish = ./configs/fish;
  };
}

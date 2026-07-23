{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # xkb-switch
    # flameshot
    # xclip
  ];
}

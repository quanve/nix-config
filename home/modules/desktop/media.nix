{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # kdePackages.kdenlive
    pavucontrol
    # easyeffects
    playerctl
    spotify
    evince
    swappy
    # krita
    cava
    mpv
  ];
}

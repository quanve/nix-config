{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    grimblast
    libinput
    hyprlock
    mpvpaper
    ydotool
    zenity
    ffmpeg
    slurp
    grim
    wbg
  ];
}

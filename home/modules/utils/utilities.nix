{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    qbittorrent
    libreoffice
    # wireshark
    localsend
    keepassxc
    libnotify
    fastfetch
    testdisk
    typst
  ];
}

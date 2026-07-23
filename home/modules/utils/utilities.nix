{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    qbittorrent
    libreoffice
    # wireshark
    keepassxc
    libnotify
    fastfetch
    testdisk
    typst
  ];
}

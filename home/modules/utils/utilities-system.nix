{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    android-tools
    # cpulimit
    usbutils
    openssl
    pamixer
    parted
    cmake
    unzip
    aria2
    ncdu
    nmap
    wget
    btop
    tree
    # htop
    dig
    jq
    fd
  ];
}

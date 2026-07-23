{ config, pkgs, lib, user, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "wireshark" "keys" "video" "input" "docker" ];
    packages = with pkgs; [];
    linger = true;
  };
}

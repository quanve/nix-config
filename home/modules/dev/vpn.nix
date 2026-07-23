{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    amnezia-vpn
    mullvad-vpn
  ];
}

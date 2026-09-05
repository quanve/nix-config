{ lib, pkgs, ... }:
{
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  programs.amnezia-vpn.enable = true;

  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    mullvad-vpn
  ];

  environment.defaultPackages = with pkgs; [
    curl
    wget
    git
    vim
    htop
    btop
    tmux
  ];
}

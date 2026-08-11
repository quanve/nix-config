# Shared configuration for both live-ISO variants (minimal / kde).
# Builds on the nixpkgs installer base: live `nixos` user, EFI+USB boot.
{ lib, pkgs, ... }:
{
  # The variant modules (`minimal.nix` / `kde.nix`) pick the concrete
  # nixpkgs installer module (minimal vs. graphical-plasma6) and edition.

  # VPN clients, present in every variant.
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

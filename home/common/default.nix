{ config, pkgs, lib, user, ... }:

{
  home.username      = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    # wget curl git fd ripgrep bat eza ...
  ];

  programs.home-manager.enable = true;

  # xdg.enable = true;
  # xdg.userDirs.enable = true;
}

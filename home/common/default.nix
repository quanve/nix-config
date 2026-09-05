{ pkgs, user, ... }:
{
  imports = [
    ../modules
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [ ];

  programs.home-manager.enable = true;
}

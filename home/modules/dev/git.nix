{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "quanve";
    userEmail = "quanvepluxary@proton.me";
  };
}

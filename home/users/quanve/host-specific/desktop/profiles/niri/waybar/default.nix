{ config, lib, pkgs, ... }:
{
  imports = [
  	# ./services.nix
  	./packages.nix
  	./configs.nix
  ];
}

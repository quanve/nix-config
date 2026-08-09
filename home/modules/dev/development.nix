{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.dev.development;
in
{
  options.myHome.modules.dev.development.enable = lib.mkEnableOption "dev/development";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      openjdk25
    ];
  };
}

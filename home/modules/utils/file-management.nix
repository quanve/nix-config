{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.utils.file-management;
in
{
  options.myHome.modules.utils.file-management.enable = lib.mkEnableOption "utils/file-management";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      file-roller
      nautilus
      gvfs
    ];
  };
}

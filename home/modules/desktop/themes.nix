{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.desktop.themes;
in
{
  options.myHome.modules.desktop.themes.enable = lib.mkEnableOption "desktop/themes";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bibata-cursors
      adw-gtk3
    ];
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.core.gnome;
in
{
  options.myHome.modules.core.gnome.enable = lib.mkEnableOption "core/gnome";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-themes-extra
      dconf-editor
      libadwaita
      nwg-look
    ];
  };
}

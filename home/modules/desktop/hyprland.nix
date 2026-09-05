{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.desktop.hyprland;
in
{
  options.myHome.modules.desktop.hyprland.enable = lib.mkEnableOption "desktop/hyprland";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpicker
      grimblast
      gammastep
      playerctl
      hyprland
      cliphist
    ];
  };
}

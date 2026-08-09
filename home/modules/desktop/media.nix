{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.desktop.media;
in
{
  options.myHome.modules.desktop.media.enable = lib.mkEnableOption "desktop/media";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # kdePackages.kdenlive
      pavucontrol
      # easyeffects
      playerctl
      spotify
      evince
      swappy
      # krita
      cava
      mpv
    ];
  };
}

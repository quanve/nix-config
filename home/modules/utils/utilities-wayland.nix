{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.utils.utilities-wayland;
in
{
  options.myHome.modules.utils.utilities-wayland.enable = lib.mkEnableOption "utils/utilities-wayland";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      grimblast
      libinput
      hyprlock
      mpvpaper
      ydotool
      zenity
      ffmpeg
      slurp
      grim
      wbg
    ];
  };
}

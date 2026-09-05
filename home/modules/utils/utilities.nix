{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.utils.utilities;
in
{
  options.myHome.modules.utils.utilities.enable = lib.mkEnableOption "utils/utilities";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qbittorrent
      libreoffice
      localsend
      keepassxc
      fastfetch
      libnotify
      testdisk
      typst
    ];
  };
}

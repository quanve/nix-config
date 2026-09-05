{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.utils.utilities-x11;
in
{
  options.myHome.modules.utils.utilities-x11.enable = lib.mkEnableOption "utils/utilities-x11";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ ];
  };
}

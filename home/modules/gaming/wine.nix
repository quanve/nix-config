{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.gaming.wine;
in
{
  options.myHome.modules.gaming.wine.enable = lib.mkEnableOption "gaming/wine";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      protonplus
      heroic
      wine
    ];
  };
}

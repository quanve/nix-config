{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.gaming.minecraft;
in
{
  options.myHome.modules.gaming.minecraft.enable = lib.mkEnableOption "gaming/minecraft";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}

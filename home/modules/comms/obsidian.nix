{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.comms.obsidian;
in
{
  options.myHome.modules.comms.obsidian.enable = lib.mkEnableOption "comms/obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}

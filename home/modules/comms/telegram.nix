{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.comms.telegram;
in
{
  options.myHome.modules.comms.telegram.enable = lib.mkEnableOption "comms/telegram";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}

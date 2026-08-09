{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.core.terminal;
in
{
  options.myHome.modules.core.terminal.enable = lib.mkEnableOption "core/terminal";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kitty
      fish
    ];
  };
}

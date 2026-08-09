{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.dev.vpn;
in
{
  options.myHome.modules.dev.vpn.enable = lib.mkEnableOption "dev/vpn";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      amnezia-vpn
      mullvad-vpn
    ];
  };
}

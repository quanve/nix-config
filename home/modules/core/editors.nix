{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.core.editors;
in
{
  options.myHome.modules.core.editors.enable = lib.mkEnableOption "core/editors";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zed-editor
      micro
    ];
  };
}

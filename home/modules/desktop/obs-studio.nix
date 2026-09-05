{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.desktop.obs-studio;
in
{
  options.myHome.modules.desktop.obs-studio.enable = lib.mkEnableOption "desktop/obs-studio";

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}

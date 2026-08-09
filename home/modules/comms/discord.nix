{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.comms.discord;
in
{
  options.myHome.modules.comms.discord.enable = lib.mkEnableOption "comms/discord";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
      })
    ];

    xdg.configFile."discord/settings.json" = {
      text = builtins.toJSON {
        SKIP_HOST_UPDATE = true;
      };
      force = true;
    };

    xdg.desktopEntries.discord = {
      name = "Discord";
      exec = "discord --enable-gpu-rasterization --blink-settings=primaryHoverType=2,primaryPointerType=4 --ozone-platform=x11 %U";
      icon = "discord";
      genericName = "Internet Messenger";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      terminal = false;
      mimeType = [ "x-scheme-handler/discord" ];
    };

    home.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "x11";
    };
  };
}

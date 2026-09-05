{
  config,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.comms.vesktop;
in
{
  options.myHome.modules.comms.vesktop.enable = lib.mkEnableOption "comms/vesktop";

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;

      discord.enable = false;

      vesktop = {
        enable = true;
        settings = {
          minimizeToTray = true;
          minimizeOnClose = true;
          winCtrlW = true;
        };
      };

      config = {
        notifyAboutUpdates = false;
        autoUpdate = false;
        useQuickCss = true;

        plugins = {
          spotifyShareCommands.enable = true;
          messageClickActions.enable = true;
          noMiddleClickPaste.enable = true;
          platformIndicators.enable = true;
          gameActivityToggle.enable = true;
          permissionsViewer.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          disableCallIdle.enable = true;
          spotifyControls.enable = true;
          previewMessage.enable = true;
          alwaysAnimate.enable = true;
          voiceDownload.enable = true;
          voiceMessages.enable = true;
          spotifyCrack.enable = true;
          memberCount.enable = true;
          serverInfo.enable = true;
          validReply.enable = true;
          callTimer.enable = true;
          fakeNitro.enable = true;
          iLoveSpam.enable = true;
          validUser.enable = true;
          messageLogger = {
            enable = true;
            deleteStyle = "overlay";
          };
          showHiddenChannels = {
            enable = true;
            showMode = 1;
          };
        };
      };
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myHome.modules.desktop.caelestia-shell;
in
{
  options.myHome.modules.desktop.caelestia-shell.enable =
    lib.mkEnableOption "desktop/caelestia-shell";

  config = lib.mkIf cfg.enable {
    programs.caelestia = {
      enable = true;

      systemd = {
        enable = false;
      };

      settings = {
        bar.statusIcons = [
          {
            id = "microphone";
            enabled = true;
          }
          {
            id = "kbLayout";
            enabled = true;
          }
        ];
        dashboard.showWeather = false;
        utilities.toasts.kbLayoutChanged = false;
      };

      cli = {
        enable = true;
        settings = {
          toggles = {
            communication = {
              discord = {
                enable = true;
                match = [ { class = "discord"; } ];
                command = [ "discord" ];
                move = true;
              };
              whatsapp = {
                enable = true;
                match = [ { class = "whatsapp"; } ];
                move = true;
              };
            };
            music = {
              spotify = {
                enable = true;
                match = [
                  { class = "Spotify"; }
                  { initial_title = "Spotify"; }
                  { initial_title = "Spotify Free"; }
                ];
                command = [
                  "spicetify"
                  "watch"
                  "-s"
                ];
                move = true;
              };
              feishin = {
                enable = true;
                match = [ { class = "feishin"; } ];
                move = true;
              };
            };
            sysmon = {
              btop = {
                enable = true;
                match = [
                  {
                    class = "btop";
                    title = "btop";
                    workspace = {
                      name = "special:sysmon";
                    };
                  }
                ];
                command = [
                  "foot"
                  "-a"
                  "btop"
                  "-T"
                  "btop"
                  "zsh"
                  "-c"
                  "exec btop"
                ];
              };
            };
            todo = {
              todoist = {
                enable = true;
                match = [ { class = "todoist"; } ];
                command = [ "todoist" ];
                move = true;
              };
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      brightnessctl
      pwvucontrol
      polkit_gnome
      trash-cli
    ];
  };
}

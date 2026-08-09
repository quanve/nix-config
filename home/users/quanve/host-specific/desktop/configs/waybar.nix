{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";

        margin-top = 0;
        margin-bottom = -11;
        margin-left = 4;
        margin-right = 4;

        modules-left = [ "niri/workspaces" "mpris" "niri/window" ];
        modules-center = [ "cpu" "memory" "custom/gpu" ];
        modules-right = [
          "pulseaudio"
          "niri/language"
          "clock"
          "tray"
          "custom/power"
        ];

        "niri/workspaces" = {
          all-outputs = false;
          format = "{value}";
        };

        mpris = {
          format = "{player_icon} {artist} - {title}";
          format-paused = "{status_icon} {artist} - {title}";
          tooltip-format = "{player} ({status})\r{artist} - {title}\r\rLeft-Click:   Play / Pause\rMiddle-Click: Previous Track\rRight-Click:  Next Track";
          title-len = 20;
          player-icons = {
            default = "▶";
            mpv = "";
            spotify = "󰓇";
            firefox = "󰈹";
          };
          status-icons = {
            paused = "";
            stopped = "";
          };
        };

        "niri/window" = {
          format = "<span color='#cdd6f4'><b>{title}</b></span>";
          separate-outputs = true;
          tooltip = false;
        };

        clock = {
          format = "<span color='#cdd6f4'><b> {:%a %d %b %H:%M}</b></span> ";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            weeks-pos = "right";
            mode-mon-col = 3;
            format = {
              months = "<span color='#cdd6f4'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#cdd6f4'><b>W{}</b></span>";
              weekdays = "<span color='#cdd6f4'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b>{}</b></span>";
            };
          };
        };

        cpu = {
          interval = 30;
          format = " CPU {usage}%";
          max-length = 13;
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = " Mem {used}GiB";
          max-length = 13;
          tooltip = false;
        };

        "custom/gpu" = {
          interval = 30;
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{print \" GPU \"$1\"%\"}'";
          max-length = 13;
          tooltip = false;
        };

        tray = {
          icon-size = 15;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} <span color='#cdd6f4'><b>{volume}%</b></span>";
          format-muted = " 󰝟 ";
          format-bluetooth = "{icon}  <span color='#cdd6f4'><b>{volume}%</b></span>";
          format-bluetooth-muted = "󰝟 ";
          format-icons = {
            headset = "";
            default = [ "󰕿 " "󰖀 " "󰕾 " ];
          };
          tooltip = true;
          on-click = "pavucontrol";
          ignored-sinks = [
            "JamesDSP Sink"
            "Easy Effects Sink"
            "HDA NVidia Digital Stereo (HDMI)"
          ];
        };

        "niri/language" = {
          format = "  <span color='#cdd6f4'><b>{short}</b></span>";
          on-click = "niri msg action switch-layout next";
          tooltip = false;
        };

        "custom/power" = {
          format = "<span color='#cdd6f4'><b></b></span>";
          tooltip = false;
          on-click = "powermenu";
        };
      }
    ];

    style = ''
      * {
          margin: 0;
          padding: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 8.5pt;
          font-weight: 800;
          transition-property: background;
          transition-duration: 0.5s;
      }
      tooltip {
          background: #11111b;
          color: #cdd6f4;
          border-radius: 5pt;
      }
      #waybar.top {
          background: none;
      }
      #waybar.top > box.horizontal {
          background: #11111b;
          box-shadow: 0 0 4pt #11111b;
          border-radius: 12pt;
	  margin: 6pt;
          padding: 2pt;
      }
      #workspaces {
          margin-left: 12pt;
      }
      #workspaces button {
          color: #585b70;
      }
      #workspaces button:not(:first-child) {
          margin-left: 2pt;
      }
      #workspaces button.visible {
          color: #89b4fa;
      }
      #workspaces button.active {
          color: #f38ba8;
      }
      #workspaces button:hover,
      #workspaces button:focus {
          background: none;
          border-color: transparent;
          box-shadow: none;
      }
      #workspaces button:hover:not(.active):not(.visible),
      #workspaces button:focus:not(.active):not(.visible) {
          color: #9399b2;
      }
      #mpris {
          background: #1e1e2e;
          color: #a6e3a1;
          border-radius: 12pt;
          margin-left: 15pt;
          padding: 0 8pt;
      }
      #window {
          margin-left: 15pt;
          margin-right: 20pt;
      }
      #cpu {
          color: #b4befe;
          margin-right: 10pt;
      }
      #memory {
          color: #fab387;
          margin-right: 10pt;
      }
      #custom-gpu {
          color: #a6e3a1;
          margin-right: 10pt;
      }
      #pulseaudio {
          color: #74c7ec;
          margin-right: 10pt;
      }
      #language {
          color: #74c7ec;
          margin-right: 10pt;
          padding: 0;
          min-width: 1.8em;
          font-weight: 900;
      }
      #tray {
          margin-right: 10pt;
      }
      #tray menu {
          background: #1e1e2e;
          padding: 2pt;
      }
      #tray menu * {
          margin: 2pt;
      }
      #tray menu check {
          margin-right: 4pt;
      }
      #custom-power {
          margin-right: 11pt;
          font-size: 10pt;
      }
      @keyframes blink {
          to {
              background-color: rgba(30, 34, 42, 0.5);
              color: #cdd6f4;
          }
      }
    '';
  };
}

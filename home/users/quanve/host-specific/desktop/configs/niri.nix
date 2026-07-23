{ pkgs, config, ... }:

let
  switchWallpaper = pkgs.writeShellApplication {
    name = "switch_wallpaper.sh";
    runtimeInputs = [ pkgs.wbg pkgs.zenity pkgs.niri pkgs.procps pkgs.gawk pkgs.coreutils ];
    text = ''
      LAST_WALLPAPER="$HOME/.last_wallpaper"

      DISPLAY_NAME=$(niri msg outputs | awk '/^[a-zA-Z0-9]/ {print $1; exit}')
      [ -z "$DISPLAY_NAME" ] && { echo "Error: display not found"; exit 1; }

      run_wbg() {
          local file="$1"
          if [ -f "$file" ]; then
              pkill -x wbg || true
              echo "Setting wallpaper: $file"
              wbg "$file" >/dev/null 2>&1 &
          else
              echo "Error: File $file not found"
              exit 1
          fi
      }

      case "''${1:-}" in
          set)
              FILE=$(zenity --file-selection --title="Select wallpaper image" --file-filter="Images | *.png *.jpg *.jpeg *.webp")
              [ -z "$FILE" ] && { echo "No file selected"; exit 1; }
              
              run_wbg "$FILE"
              echo "$FILE" > "$LAST_WALLPAPER"
              ;;
              
          start)
              if [ -f "$LAST_WALLPAPER" ]; then
                  FILE=$(cat "$LAST_WALLPAPER")
                  run_wbg "$FILE"
              else
                  echo "History file $LAST_WALLPAPER not found. Use 'set'."
                  exit 1
              fi
              ;;
              
          *)
              echo "Usage: $0 {set|start}"
              echo "  set   - select and apply a new wallpaper"
              echo "  start - launch the last saved wallpaper"
              exit 1
              ;;
      esac
    '';
  };
in
{
  home.packages = [ switchWallpaper ];

  programs.niri = {
    enable = true;
    settings = {
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
      };

      environment = {
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland,x11,*";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "dunst" ]; }
        { command = [ "${switchWallpaper}/bin/switch_wallpaper.sh" "start" ]; }
      ];

      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
          repeat-delay = 250;
          repeat-rate = 35;
          numlock = true;
        };

        mouse = {
          accel-profile = "flat";
          accel-speed = -0.58;
        };
        
	focus-follows-mouse = {
	  enable = true;
          max-scroll-amount = "0%";
        };
      };

      layout = {
        gaps = 10;

        struts = {
          left = 15;
          right = 17;
          top = 15;
          bottom = 15;
        };

        focus-ring = {
          width = 2;
          active.color = "#89b4fa";
          inactive.color = "#313244";
        };

        border.enable = false;
      };

      prefer-no-csd = true;
      screenshot-path = null;

      animations = {
        slowdown = 1.0;

        workspace-switch.kind = {
          spring = { damping-ratio = 1.0; stiffness = 1000; epsilon = 0.0001; };
        };
        window-open.kind = {
          easing = {
            duration-ms = 250;
            curve = "ease-out-expo";
          };
        };
        window-close.kind = {
          easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };
        };
        window-movement.kind = {
          spring = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
        };
        window-resize.kind = {
          spring = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
        };
        horizontal-view-movement.kind = {
          spring = { damping-ratio = 1.0; stiffness = 800; epsilon = 0.0001; };
        };
        config-notification-open-close.kind = {
          spring = { damping-ratio = 0.6; stiffness = 1000; epsilon = 0.001; };
        };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
          #opacity = 0.92;
        }
        {
          matches = [ { title = "^[Pp]icture-[I|i]n-[P|p]icture$"; } ];
          open-floating = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Return".action.spawn = "kitty";
        "Mod+E".action.spawn = [ "nautilus" "--new-window" ];
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Shift+F".action.spawn = "firefox";
        "Mod+Alt+T".action.spawn = [ "${switchWallpaper}/bin/switch_wallpaper.sh" "set" ];
        "Mod+Shift+S".action.screenshot = { };

        "Mod+C".action.close-window = { };
        "Mod+Space".action.toggle-window-floating = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+Return".action.fullscreen-window = { };
        "Mod+Z".action.center-column = { };
        "Mod+O".action.toggle-overview = { };

        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Down".action.focus-window-down = { };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;

        "Mod+Shift+1".action.move-window-to-workspace = 1;
        "Mod+Shift+2".action.move-window-to-workspace = 2;
        "Mod+Shift+3".action.move-window-to-workspace = 3;
        "Mod+Shift+4".action.move-window-to-workspace = 4;
        "Mod+Shift+5".action.move-window-to-workspace = 5;
        "Mod+Shift+6".action.move-window-to-workspace = 6;
        "Mod+Shift+7".action.move-window-to-workspace = 7;
        "Mod+Shift+8".action.move-window-to-workspace = 8;
        "Mod+Shift+9".action.move-window-to-workspace = 9;
        "Mod+Shift+0".action.move-window-to-workspace = 10;

        "Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = { }; };
        "Mod+WheelScrollUp" = { cooldown-ms = 150; action.focus-workspace-up = { }; };
        "Mod+Shift+WheelScrollDown" = { cooldown-ms = 150; action.focus-column-right = { }; };
        "Mod+Shift+WheelScrollUp" = { cooldown-ms = 150; action.focus-column-left = { }; };
        "Mod+WheelScrollRight" = { cooldown-ms = 150; action.focus-column-right = { }; };
        "Mod+WheelScrollLeft" = { cooldown-ms = 150; action.focus-column-left = { }; };

        "XF86AudioRaiseVolume" = { allow-when-locked = true; action.spawn = [ "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+" ]; };
        "XF86AudioLowerVolume" = { allow-when-locked = true; action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ]; };
        "XF86AudioMute" = { allow-when-locked = true; action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ]; };
        "XF86AudioMicMute" = { allow-when-locked = true; action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ]; };
        "XF86MonBrightnessUp" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "-e4" "-n2" "set" "5%+" ]; };
        "XF86MonBrightnessDown" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "-e4" "-n2" "set" "5%-" ]; };

        "XF86AudioNext" = { allow-when-locked = true; action.spawn = [ "playerctl" "next" ]; };
        "XF86AudioPrev" = { allow-when-locked = true; action.spawn = [ "playerctl" "previous" ]; };
        "XF86AudioPlay" = { allow-when-locked = true; action.spawn = [ "playerctl" "play-pause" ]; };
        "XF86AudioPause" = { allow-when-locked = true; action.spawn = [ "playerctl" "play-pause" ]; };

        "Ctrl+Alt+Delete".action.spawn = "powermenu";
        "Mod+L".action.spawn = "hyprlock";
        "Mod+Shift+E".action.quit = { };

        "Mod+N".action.spawn = [ "dunstctl" "history-pop" ];
        "Mod+Shift+N".action.spawn = "dunst-menu";
        "Mod+Alt+C".action.spawn = [ "dunstctl" "history-clear" ];

        "Ctrl+Shift+Alt+V".action.spawn = [
          "bash"
          "-c"
          "sleep 0.5 && ydotool type -d 1 \"$(cliphist list | head -1 | cliphist decode)\""
        ];
      };
    };
  };
}

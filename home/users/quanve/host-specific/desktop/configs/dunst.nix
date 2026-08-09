{ pkgs, ... }:
let
  dunstMenu = pkgs.writeShellApplication {
    name = "dunst-menu";
    runtimeInputs = [ pkgs.dunst pkgs.jq pkgs.fuzzel pkgs.gawk pkgs.wl-clipboard pkgs.libnotify ];
    text = ''
      command -v dunstctl >/dev/null || exit 1
      command -v jq >/dev/null || exit 1

      icon() {
        case "$1" in
          Discord) echo "" ;;
          Spotify) echo "" ;;
          Telegram) echo "" ;;
          *) echo "" ;;
        esac
      }

      menu=$(dunstctl history | jq -r '
        .data[0][] |
        {
          id: .id.data,
          app: .appname.data,
          summary: .summary.data,
          body: .body.data,
          time: (.timestamp.data / 1000000 | strftime("%H:%M"))
        } |
        "\(.id)|\(.app)|\(.summary) \(.body)|\(.time)"
      ')

      menu=$(while IFS="|" read -r id app text time; do
        ic=$(icon "$app")
        printf "%s %s | %s | %s || %s\n" "$ic" "$app" "$text" "$time" "$id"
      done <<< "$menu")

      menu="🗑 Clear all\n$menu"

      chosen=$(printf "%b" "$menu" | fuzzel --dmenu)

      [ -z "$chosen" ] && exit 0

      if [[ "$chosen" == "🗑 Clear all" ]]; then
        dunstctl history-clear
        notify-send -a "notif-menu" "Notifications cleared"
        exit 0
      fi

      id=$(echo "$chosen" | awk -F '|| ' '{print $2}')
      text=$(echo "$chosen" | cut -d '|' -f2)

      action=$(printf "Copy\nDelete\nBack" | fuzzel --dmenu)

      case "$action" in
        Copy)
          echo "$text" | wl-copy
          notify-send -a "notif-menu" "Copied" "$text"
          ;;
        Delete)
          dunstctl history-rm "$id"
          notify-send -a "notif-menu" "Deleted notification"
          ;;
        Back)
          exec "$0"
          ;;
      esac
    '';
  };
in
{
  home.packages = [ dunstMenu ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        shrink = "no";
        padding = 20;
        horizontal_padding = 20;

        width = 320;
        height = 400;
        offset = "16x60";
        origin = "top-right";

        frame_width = 2;
        separator_height = 2;

        frame_color = "#313244";
        separator_color = "#313244";

        sort = "no";
        font = "JetBrainsMono Nerd Font 15";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = "no";
        show_indicators = "yes";

        icon_position = "left";
        max_icon_size = 60;
        sticky_history = "yes";
        history_length = 50;
        title = "Dunst";
        class = "Dunst";

        corner_radius = 10;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 5;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 10;
      };

      "notif-menu" = {
        appname = "notif-menu";
        history_ignore = "yes";
      };

      spotify = {
        appname = "Spotify";
        history_ignore = "yes";
      };
    };
  };
}

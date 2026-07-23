#!/usr/bin/env bash

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

#!/usr/bin/env bash

command -v wbg >/dev/null 2>&1 || { echo "Error: wbg not installed"; exit 1; }
command -v zenity >/dev/null 2>&1 || { echo "Error: zenity not installed"; exit 1; }
command -v niri >/dev/null 2>&1 || { echo "Error: niri not installed"; exit 1; }

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

case "${1:-}" in
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

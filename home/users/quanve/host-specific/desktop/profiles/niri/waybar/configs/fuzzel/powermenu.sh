#!/usr/bin/env bash

options=" Shutdown
 Reboot
󰍃 Logout
 Suspend
 Lock"

chosen=$(printf "%s\n" "$options" | fuzzel --dmenu)

case "$chosen" in
  *Shutdown) systemctl poweroff ;;
  *Reboot) systemctl reboot ;;
  *Logout) hyprctl dispatch exit ;;
  *Suspend) systemctl suspend ;;
  *Lock) loginctl lock-session ;;
esac

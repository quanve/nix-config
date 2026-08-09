{ pkgs, ... }:
let
  powermenu = pkgs.writeShellApplication {
    name = "powermenu";
    runtimeInputs = [
      pkgs.fuzzel
      pkgs.hyprland
      pkgs.systemd
    ];
    text = ''
      options=" Shutdown\n Reboot\n󰍃 Logout\n Suspend\n Lock"

      chosen=$(echo -e "$options" | fuzzel --dmenu)

      case "$chosen" in
        *Shutdown) systemctl poweroff ;;
        *Reboot) systemctl reboot ;;
        *Logout) hyprctl dispatch exit ;;
        *Suspend) systemctl suspend ;;
        *Lock) loginctl lock-session ;;
      esac
    '';
  };
in
{
  home.packages = [ powermenu ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono NF:size=17";
        terminal = "foot -e";
        prompt = "\"> \"";
        layer = "overlay";
        lines = 15;
        width = 60;
        dpi-aware = "no";
        inner-pad = 10;
        horizontal-pad = 40;
        vertical-pad = 15;
        match-counter = "yes";
      };

      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "89b4faff";
        placeholder = "a6adc8ff";
        input = "cdd6f4ff";
        match = "f38ba8ff";

        selection = "89b4fa88";
        selection-text = "1e1e2eff";
        selection-match = "f38ba8ff";

        counter = "a6adc8ff";
        border = "89b4fa88";
      };

      border = {
        radius = 10;
        width = 2;
      };
    };
  };
}

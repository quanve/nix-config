{ pkgs, lib, ... }:

{
  wayland.windowManager.river = {
    enable = true;

    settings = {
      border-width = 2;
      color-focused = "0x81a1c1";
      color-unfocused = "0x4c566a";

      input = {
        "pointer-*" = {
          accel-profile = "flat";
          pointer-acceleration = "-0.58";
        };
      };

      map.normal = let
        baseBinds = {
          "Mod4 Return" = "spawn kitty";
          "Mod4 D" = "spawn 'rofi -show drun'";

          "Mod4 Q" = "close";
          "Mod4+Shift E" = "exit";

          "Mod4 J" = "focus-view next";
          "Mod4 K" = "focus-view previous";
          "Mod4+Shift J" = "swap next";
          "Mod4+Shift K" = "swap previous";

          "Mod4 H" = "main-ratio -0.05";
          "Mod4 L" = "main-ratio +0.05";
          "Mod4 Space" = "toggle-float";
        };

        tagValues = [ 1 2 4 8 16 32 64 128 256 ];

        mkTagBinds = index: let
          tagName = toString (index + 1);
          tagValue = toString (builtins.elemAt tagValues index);
        in {
          "Mod4 ${tagName}" = "set-focused-tags ${tagValue}";
          "Mod4+Shift ${tagName}" = "set-view-tags ${tagValue}";
          "Mod4+Control ${tagName}" = "toggle-focused-tags ${tagValue}";
        };

        allTags = map mkTagBinds (lib.range 0 8);

      in lib.foldr lib.recursiveUpdate baseBinds allTags;

      spawn = [
        "${pkgs.river}/bin/rivertile"
      ];

      default-layout = "rivertile";
    };
  };
}

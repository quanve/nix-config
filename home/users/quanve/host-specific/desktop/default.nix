{ ... }:
{
  imports = [
    ./configs
    ../../../../modules/utils/nixvim.nix
  ];

  myHome.modules = {
    core.gnome.enable = true;

    desktop = {
      obs-studio.enable = true;
      firefox.enable = true;
      themes.enable = true;
      media.enable = true;
      hyprland.enable = true;
      caelestia-shell.enable = true;
    };

    dev = {
      reverse-engineering.enable = true;
      vpn.enable = true;
    };

    gaming = {
      minecraft.enable = true;
      wine.enable = true;
    };

    utils = {
      utilities-wayland.enable = true;
      utilities-x11.enable = true;
      nixvim.enable = true;
    };
  };
}

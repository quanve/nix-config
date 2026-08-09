{ ... }:
{
  imports = [
    ./configs
  ];

  # Modules enabled only on this host (in addition to the user-level set).
  myHome.modules = {
    core.gnome.enable = true;

    desktop = {
      obs-studio.enable = true;
      firefox.enable = true;
      themes.enable = true;
      media.enable = true;
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
    };
  };
}

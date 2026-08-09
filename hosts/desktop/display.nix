{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.ly.enable = true;

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-hyprland
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}

{ config, pkgs, lib, inputs, ... }:
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    flatpak = {
      enable = true;
    };

    gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = true;
    };

    displayManager.ly.enable = true;
    gvfs.enable = true;
  };

  programs = {
    throne = {
      enable = true;
      tunMode.enable = true;
    };

    firejail.enable = true;

    niri.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

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

{ config, pkgs, ... }:
{
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      # System-level dependencies
      nvidia-vaapi-driver
      xwayland-satellite
      wayland-protocols
      btrfs-progs
      libva-utils
      tpm2-tools
      efitools
      libvdpau
      ethtool
      libva
      sbctl
      git

      r2modman
      
    ];
  };
}

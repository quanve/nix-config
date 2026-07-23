{ config, pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
        vulkan-loader
        libglvnd
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        libglvnd
      ];
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", ATTRS{idProduct}=="1054", TAG+="uaccess"
  '';

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # zramSwap = {
  #   enable = true;
  #   algorithm = "zstd";
  #   memoryPercent = 50;
  # };
}

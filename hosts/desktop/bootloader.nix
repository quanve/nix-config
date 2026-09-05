{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];

    kernelModules = [
      "v4l2loopback"
      "tpm_tis"
      "tun"
    ];

    kernelParams = [
      "printk.always_kmsg_dump=1"
      "resume_offset=533760"
      "8250.nr_uarts=0"
      "amd_iommu=on"
      "iommu=pt"
    ];

    blacklistedKernelModules = [
      "thunderbolt"
      "bluetooth"
      "uvcvideo"
      "btusb"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    loader = {
      systemd-boot = {
        enable = false;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;
  };
}

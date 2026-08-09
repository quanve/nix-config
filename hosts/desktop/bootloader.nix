{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    resumeDevice = "/dev/mapper/luks-ssd";

    kernelModules = [
      "tun"
      "v4l2loopback"
      "tpm_tis"
    ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "resume_offset=533760"
      "8250.nr_uarts=0"
      "printk.always_kmsg_dump=1"
    ];

    blacklistedKernelModules = [
      "bluetooth"
      "btusb"
      "thunderbolt"
      "uvcvideo"
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

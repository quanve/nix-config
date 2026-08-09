{ ... }:
{
  imports = [
    # ./hardware-configuration.nix
    ./users.nix
  ];

  # Placeholder boot config so `nix flake check` can evaluate/build this
  # host's toplevel. Replace with a generated hardware-configuration.nix
  # (and drop these two lines) once the machine is set up.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "framework";

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # powerManagement.cpuFreqGovernor = "schedutil";
  # hardware.bluetooth.enable = true;
}

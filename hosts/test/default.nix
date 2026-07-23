{ config, pkgs, lib, ... }:

{
  imports = [
    # ./hardware-configuration.nix   # ← сгенерируете позже
  ];

  networking.hostName = "framework";

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # powerManagement.cpuFreqGovernor = "schedutil";
  # hardware.bluetooth.enable = true;
}

{ ... }:
{
  # GPU passthrough boot entry, used for VFIO on the current
  # Intel + NVIDIA machine. Drop this file (or the import in
  # default.nix) on machines that don't need it.
  #
  # On an AMD host the kernel params differ:
  #   "amd_iommu=on"
  #   "iommu=pt"
  #   "vfio-pci.ids=<vendor>:<device>"
  # and IOMMU must be enabled in the firmware.
  specialisation.vfio-passthrough = {
    configuration.boot = {
      kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

      kernelParams = [
        "intel_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=10de:1c82,10de:0fb9"
      ];

      blacklistedKernelModules = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nouveau" ];

      extraModprobeConfig = ''
        options vfio-pci ids=10de:1c82,10de:0fb9
      '';
    };
  };
}

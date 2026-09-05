{ ... }:
{
  specialisation.vfio-passthrough = {
    configuration.boot = {
      kernelModules = [
        "vfio_iommu_type1"
        "vfio_virqfd"
        "vfio_pci"
        "vfio"
      ];

      kernelParams = [
        "vfio-pci.ids=10de:1c82,10de:0fb9"
        "amd_iommu=on"
        "iommu=pt"
      ];

      blacklistedKernelModules = [
        "nvidia_modeset"
        "nvidia_drm"
        "nvidia_uvm"
        "nouveau"
        "nvidia"
      ];

      extraModprobeConfig = ''
        options vfio-pci ids=10de:1c82,10de:0fb9
      '';
    };
  };
}

let
  # Mobile RTX 3060
  gpuIDs = [
    "10de:2520" # Graphics
    "10de:228e" # Audio
  ];
in { config, lib, pkgs, ... }: {
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";

  config = let cfg = config.vfio;
  in {
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
      ];

      kernelParams = [
        # enable IOMMU
        "intel_iommu=on"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);

    };

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.ovmf.enable = true;
        qemu.swtpm.enable = true;
      };

      spiceUSBRedirection.enable = true;
    };
  };
}

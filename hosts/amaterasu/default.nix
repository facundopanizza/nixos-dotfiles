# amaterasu - Laptop with Intel CPU + NVIDIA GPU
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    # ../../apps/gpu-passthrough  # Optional, for VFIO passthrough
  ];

  networking.hostName = "amaterasu";

  # Use latest kernel for WiFi 7 support (Qualcomm WCN785x / ath12k)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Required for WiFi firmware (ath12k)
  hardware.enableRedistributableFirmware = true;

  # Graphics
  hardware.graphics.enable = true;

  # NVIDIA drivers
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management (experimental, can cause sleep/suspend issues)
    powerManagement.enable = false;

    # Fine-grained power management (Turing or newer)
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not nouveau)
    # Currently alpha-quality/buggy, so false is recommended
    open = false;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # NVIDIA Optimus (Intel + NVIDIA hybrid)
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # NVIDIA container toolkit for Docker
  hardware.nvidia-container-toolkit.enable = true;
}

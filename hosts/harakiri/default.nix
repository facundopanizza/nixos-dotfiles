# harakiri - Desktop with AMD CPU + AMD GPU
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "harakiri";

  # AMD GPU - uses open source drivers automatically (no special config needed)
  hardware.graphics.enable = true;

  # Optional: Enable AMDGPU in initrd for faster boot with AMD GPU
  # hardware.amdgpu.initrd.enable = true;
}

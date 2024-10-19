{ nixalien, ... }:

{
  environment.systemPackages = with nixalien; [
    nix-alien
  ];

  # Optional, but this is needed for `nix-alien-ld` command
  programs.nix-ld.enable = true;
}

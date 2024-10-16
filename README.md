For updating
nix flake update

For running config

sudo nixos-rebuild switch --flake .

For running config with different hostname
sudo nixos-rebuild switch --flake .#new-hostname

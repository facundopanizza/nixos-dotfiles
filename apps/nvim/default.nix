{ inputs, ... }:
{
  imports = [
    ./config.nix
    ./plugins.nix
  ];

  programs.nixvim = {
     enable = true;
  };
}


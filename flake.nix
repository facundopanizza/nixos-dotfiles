{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstableu";
    chaotic.url = "github:chaotic-cx/nyx/18ce11ef64c0d89b48bc9ee73f9b82d7e8f3abc9"; # Had to pin beacuse 6.12 kernel is not support for Nvidia drivers yet

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, stylix, chaotic, ... }@inputs: 
    let
      system = "x86_64-linux";

      nixalien = inputs.nix-alien.packages.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;

        modules = [
          ./configuration.nix
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          chaotic.nixosModules.default
        ];

        specialArgs = { 
          inherit inputs;
          nixalien = nixalien;
          stylix = stylix;
        };
      };
    };
}


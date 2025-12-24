{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # Laptop: Intel CPU + NVIDIA GPU
      nixosConfigurations.amaterasu = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/amaterasu
          stylix.nixosModules.stylix
        ];
        specialArgs = { inherit inputs; };
      };

      # Desktop: AMD CPU + AMD GPU
      nixosConfigurations.harakiri = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/harakiri
          stylix.nixosModules.stylix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}


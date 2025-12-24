{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    orcaslicerpkgs = {
      url = "github:nixos/nixpkgs/4ae2e647537bcdbb82265469442713d066675275";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, stylix, ... }@inputs: 
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;

        modules = [
          ./configuration.nix
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
        ];

        specialArgs = { 
          inherit inputs;
          stylix = stylix;
        };
      };
    };
}


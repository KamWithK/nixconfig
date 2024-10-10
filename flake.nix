{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    # Optional, to download less. Neither the module nor the overlay uses this input.
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
  in {
    packages = import ./pkgs nixpkgs.legacyPackages.${system};
    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      gigatop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/machines/gigatop/configuration.nix ];
      };
    };
    homeConfigurations = {
      "kamwithk@gigatop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.nix-doom-emacs-unstraightened.hmModule
          ./home-manager/users/kamwithk.nix
        ];
      };
    };
  };
}

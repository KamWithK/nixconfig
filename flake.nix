{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-master.url = "github:nixos/nixpkgs";

    stylix.url = "github:danth/stylix";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    # Optional, to download less. Neither the module nor the overlay uses this input.
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      secrets = builtins.fromJSON (builtins.readFile "${self}/secrets.json");
    in
    {
      packages = import ./pkgs nixpkgs.legacyPackages.${system};
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        gigatop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs secrets;
          };
          modules = with inputs; [
            stylix.nixosModules.stylix
            ./hosts/machines/gigatop/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "kamwithk@gigatop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs secrets;
          };
          modules = with inputs; [
            stylix.homeManagerModules.stylix
            nix-doom-emacs-unstraightened.hmModule
            ./home-manager/users/kamwithk.nix
          ];
        };
      };
    };
}

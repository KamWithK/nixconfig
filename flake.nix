{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-master.url = "github:nixos/nixpkgs";

    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix/release-24.05";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      packages = import ./pkgs nixpkgs.legacyPackages.${system};
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        gigatop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = with inputs; [
            agenix.nixosModules.default
            { age.identityPaths = [ "/etc/ssh/ssh_host_rsa_key" ]; }
            stylix.nixosModules.stylix
            ./hosts/machines/gigatop/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "kamwithk@gigatop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = with inputs; [
            agenix.homeManagerModules.default
            stylix.homeManagerModules.stylix
            nix-doom-emacs-unstraightened.hmModule
            ./home-manager/users/kamwithk.nix
          ];
        };
      };
    };
}

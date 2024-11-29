{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
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
            spicetify-nix.homeManagerModules.default
            ./home-manager/users/kamwithk.nix
          ];
        };
      };
    };
}

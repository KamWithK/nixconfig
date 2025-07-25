{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
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
      originPkgs = import nixpkgs { inherit system; };
      patchedNixpkgs = originPkgs.applyPatches {
        name = "nixpkgs-patched";
        src = nixpkgs;
        patches = [ ];
      };
      patchedPkgs = import patchedNixpkgs { inherit system; };
      patchedNixOS = import (patchedNixpkgs + /nixos/lib/eval-config.nix);
    in
    {
      nixpkgs = patchedPkgs;
      packages = patchedPkgs;
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        gigatop = patchedNixOS {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = with inputs; [
            agenix.nixosModules.default
            {
              age.identityPaths = [
                "/home/kamwithk/.ssh/id_ed25519"
                "/etc/ssh/ssh_host_rsa_key"
              ];
            }
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
            stylix.homeModules.stylix
            spicetify-nix.homeManagerModules.default
            ./home-manager/users/kamwithk.nix
          ];
        };
      };
    };
}

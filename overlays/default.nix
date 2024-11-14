# Source - https://github.com/Misterio77/nix-starter-configs/blob/main/standard/overlays/default.nix
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs { pkgs = final; };
  additions =
    final: _prev:
    import ../pkgs {
      pkgs = import inputs.nixpkgs {
        system = final.system;
        config.allowUnfree = true;
      };
    };

  master-packages = final: _prev: {
    master = import inputs.nixos-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
        packages = ((flake.packages or { }).${final.system} or { });
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };
}

# NixOS Configuration
My reproducible NixOS configuration

Largely inspired by [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs), but simplified down further

## Install

1. Install git, optionally gh, and then clone config
2. Set hostname to `gigatop` (or modify config)
3. Comment out anything requiring secrets (or set up agenix)
4. `sudo nixos-rebuild switch --flake .#gigatop`
5. `home-manager switch --flake .#kamwithk@gigatop`

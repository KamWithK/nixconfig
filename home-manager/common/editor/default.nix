{ pkgs, ... }:

{
  imports = [
    ./code_tools.nix
    ./lsp.nix
    ./helix.nix
    ./neovim.nix
    ./emacs.nix
  ];

  home.packages = with pkgs; [
    nnd
    krita
    blender
    android-studio
  ];
}

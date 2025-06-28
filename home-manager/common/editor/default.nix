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
    godot
    krita
    blender
    android-studio
  ];
}

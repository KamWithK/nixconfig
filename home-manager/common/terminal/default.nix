{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./git.nix
  ];

  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.carapace.enable = true;

  programs.alacritty.enable = true;

  nixpkgs.config.environment.variables = {
    TERMINAL = "alacritty";
  };

  home.packages = with pkgs; [
    tree
    wget
    xclip
    unp
    unrar
    pokeget-rs

    playerctl
  ];
}

{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./nushell.nix
    ./zellij.nix
    ./starship.nix
    ./yazi.nix
    ./git.nix
  ];

  programs.jq.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.carapace.enable = true;
  programs.thefuck.enable = true;

  programs.foot.enable = true;
  programs.alacritty.enable = true;

  nixpkgs.config.environment.variables = {
    TERMINAL = "foot";
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

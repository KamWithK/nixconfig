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

  programs.bat = {
    enable = true;

    extraPackages = with pkgs.bat-extras; [
      batman
      batgrep
      batdiff
    ];
  };
  home.shellAliases = {
    cat = "bat";
    man = "batman";
    grep = "batgrep";
    diff = "batdiff";

    up = "sudo nix flake update";
    hm = "home-manager switch --flake .#kamwithk@gigatop";
    syst = "sudo nixos-rebuild switch --flake .#gigatop";
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.carapace.enable = true;
  programs.thefuck.enable = true;

  programs.foot.enable = true;
  programs.alacritty.enable = true;

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
  };

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
  ];
}

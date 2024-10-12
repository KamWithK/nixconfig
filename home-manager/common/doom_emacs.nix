{ pkgs, config, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomDir = ../../dotfiles/doom;
    emacs = pkgs.emacs29-pgtk;
    extraPackages = epkgs: config.programs.emacs.extraPackages epkgs ++ [ epkgs.treesit-grammars.with-all-grammars ];
    extraBinPackages = with pkgs; [ git ripgrep fd ispell shellcheck pandoc nixfmt-classic nodePackages.npm ];
  };
  services.emacs.enable = true;
}

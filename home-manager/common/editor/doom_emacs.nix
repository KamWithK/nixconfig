{ pkgs, config, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomDir = ../../../dotfiles/emacs/doom;
    emacs = pkgs.emacs29-pgtk;
    provideEmacs = false;
    extraPackages =
      epkgs: config.programs.emacs.extraPackages epkgs ++ [ epkgs.treesit-grammars.with-all-grammars ];
  };
}

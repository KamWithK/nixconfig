{ pkgs, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomDir = ../../dotfiles/doom;
    emacs = pkgs.emacs29-pgtk;
  };
}

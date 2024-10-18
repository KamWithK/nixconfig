{ pkgs, ... }:

let
  emacsPkg = pkgs.emacs29-pgtk;
in
{
  programs.emacs = {
    enable = true;
    package = emacsPkg;
  };
  services.emacs = {
    enable = true;
    package = emacsPkg;
  };
}

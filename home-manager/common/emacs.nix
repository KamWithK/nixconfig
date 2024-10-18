{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk.pkgs.withPackages (epkgs: [ epkgs.treesit-grammars.with-all-grammars ]);
  };
}

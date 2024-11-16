{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk.pkgs.withPackages (epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.all-the-icons
    ]);
  };

  xdg.configFile."emacs/init.el".source = ../../../dotfiles/emacs/gnu/init.el;
}

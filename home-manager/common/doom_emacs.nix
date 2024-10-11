{ pkgs, config, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomDir = ../../dotfiles/doom;
    emacs = pkgs.emacs29-pgtk;
      extraPackages = config.programs.emacs.extraPackages;
  };
  services.emacs.enable = true;
}

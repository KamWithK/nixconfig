{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme.name = "Papirus-Dark-Maia";
    iconTheme.package = pkgs.papirus-maia-icon-theme;
  };
  home.packages = [ pkgs.dconf ];
}

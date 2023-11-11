{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font.name = "Noto Sans";
    font.package = pkgs.noto-fonts;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
    iconTheme.name = "Papirus-Dark-Maia";
    iconTheme.package = pkgs.papirus-maia-icon-theme;
  };
}

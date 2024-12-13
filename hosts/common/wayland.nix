{ pkgs, ... }:
{
  programs.hyprland = {
    enable = false;
    xwayland.enable = true;
  };
  programs.river = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}

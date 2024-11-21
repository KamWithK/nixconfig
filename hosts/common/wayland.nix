{ pkgs, ... }:
{
  programs.hyprland = {
    enable = false;
    xwayland.enable = false;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}

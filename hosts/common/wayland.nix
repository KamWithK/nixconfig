{ ... }:
{
  programs.hyprland = {
    enable = false;
    xwayland.enable = true;
  };
  programs.river = {
    enable = true;
    xwayland.enable = true;
  };
}

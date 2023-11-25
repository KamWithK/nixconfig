{ pkgs, ... }:

{
  config.home.file = {
    ".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
  };

  config.home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
  config.programs.chromium.commandLineArgs = "--enable-wayland-ime";

  config.home.packages = with pkgs; [
    waybar
    swaynotificationcenter
    rofi-wayland
    wl-clipboard
    grim
    slurp
    unstable.xwaylandvideobridge
  ];
}

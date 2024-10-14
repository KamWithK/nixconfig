{ pkgs, ... }:

{
  config.home.file = {
    ".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
  };

  config.home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
  config.programs.chromium.commandLineArgs = [ "--enable-wayland-ime" ];

  config.programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  config.home.packages = with pkgs; [
    waybar
    swaynotificationcenter
    wl-clipboard
    grim
    slurp
    unstable.xwaylandvideobridge
  ];
}

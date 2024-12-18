{ pkgs, ... }:

{
  imports = [
    ./waybar.nix

    # ./bspwm.nix
    ./hyprland.nix
    ./river.nix
    # ./ime.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  # config.programs.chromium.commandLineArgs = [ "--enable-wayland-ime" ];

  services.swaync.enable = true;
  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    xwaylandvideobridge
  ];
}

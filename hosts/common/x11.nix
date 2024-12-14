{ pkgs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig.PartialBlur = "false";
  };
in
{
  # Enable the X11 windowing system.
  # Configure keymap in X11
  services.xserver = {
    enable = true;

    xkb = {
      variant = "";
      layout = "us";
    };

    # libinput.enable = true; # touchpad support

    windowManager.bspwm.enable = true;
    windowManager.hypr.enable = false;

    # ~/.background-image loaded by default on x11
    desktopManager.wallpaper.mode = "fill";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = [ sddm-astronaut ];

    theme = "sddm-astronaut-theme";
  };

  environment.systemPackages = [
    sddm-astronaut
  ];
}

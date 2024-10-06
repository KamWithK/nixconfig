{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  # Configure keymap in X11
  services.xserver = {
    enable = false;

    xkb = {
      variant = "";
      layout = "us";
    };

    # libinput.enable = true; # touchpad support

    # windowManager.bspwm.enable = true;
    windowManager.hypr.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    wayland.enable = true;
  };

  # Theme for sddm
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    unstable.sddm-chili-theme
  ];

  # ~/.background-image loaded by default on x11
  services.xserver.desktopManager.wallpaper.mode = "fill";
}

{ pkgs, ... }:
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
    # windowManager.hypr.enable = true;

    # ~/.background-image loaded by default on x11
    desktopManager.wallpaper.mode = "fill";
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    wayland.enable = false;
  };

  # Theme for sddm
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    unstable.sddm-chili-theme
  ];
}

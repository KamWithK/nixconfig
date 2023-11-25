{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # libinput.enable = true; # touchpad support

    displayManager.sddm = {
      enable = true;
      theme = "chili";
    };
    windowManager.bspwm.enable = true;
    # windowManager.hypr.enable = true;
  };

  # Theme for sddm
  environment.systemPackages = with pkgs.unstable; [
      sddm-chili-theme
  ];

  # ~/.background-image loaded by default on x11
  services.xserver.desktopManager.wallpaper.mode = "fill";
}

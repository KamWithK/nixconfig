{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        ControllerMode = "dual";
        # A2DP support
        Enable = "Source,Sink,Media,Socket";
        # Battery level display
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;
}

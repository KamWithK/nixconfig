{ ... }:
{
  services.redshift = {
    enable = false;
    tray = true;

    provider = "manual";
    latitude = -37.81417;
    longitude = 144.96306;
  };
}

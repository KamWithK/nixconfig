{ pkgs, secrets, ... }:
{
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "enp42s0";
      WIFI_IFACE = "wlp33s0";
      SSID = "WIFI";
      PASSPHRASE = secrets.hotspot.passphrase;
    };
  };

  environment.systemPackages = with pkgs; [ linux-wifi-hotspot ];
}

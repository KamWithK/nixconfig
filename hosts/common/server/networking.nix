{ config, ... }:

{
  networking.firewall.allowedTCPPorts = [
    80
    443
    8554
    9002
  ];
  networking.firewall.allowedUDPPorts = [
    8554
    4819
    9002
  ];

  age.secrets.caddy.file = ../../../secrets/caddy.age;

  programs.wireshark.enable = true;

  security.acme = {
    acceptTerms = true;

    defaults = {
      email = "kamwithk@tuta.io";
      group = config.services.caddy.group;
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      environmentFile = config.age.secrets.caddy.path;
    };

    certs."kamwithk.com" = {
      domain = "kamwithk.com";
      extraDomainNames = [ "*.kamwithk.com" ];
    };
  };

  services.caddy = {
    enable = true;

    virtualHosts = {
      "navidrome.kamwithk.com" = {
        useACMEHost = "kamwithk.com";
        extraConfig = "reverse_proxy localhost:4533";
      };
      "actual.kamwithk.com" = {
        useACMEHost = "kamwithk.com";
        extraConfig = "reverse_proxy localhost:3000";
      };
    };
  };
}

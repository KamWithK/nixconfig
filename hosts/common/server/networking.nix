{ config, ... }:

{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;

    defaults = {
      email = "kamwithk@tuta.io";
      group = config.services.caddy.group;
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      environmentFile = ../../../secrets/cloudflare.secret;
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
    };
  };
}

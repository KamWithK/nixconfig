{ config, pkgs, ... }:

{
  age.secrets.navidrome = {
    file = ../../../secrets/navidrome.age;
    owner = config.services.navidrome.user;
    group = config.services.navidrome.group;
  };

  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/Music/";
    };

    environmentFile = config.age.secrets.navidrome.path;
  };

  environment.systemPackages = with pkgs; [ navidrome ];
}

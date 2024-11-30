{ config, pkgs, ... }:

{
  age.secrets.navidrome = {
    file = ../../../secrets/navidrome.age;
    owner = config.services.navidrome.user;
    group = config.services.navidrome.group;
  };

  services.navidrome = {
    enable = true;

    user = "kamwithk";

    settings = {
      MusicFolder = "/run/media/kamwithk/Media/Music";
    };

    credentialsFile = config.age.secrets.navidrome.path;
  };

  environment.systemPackages = with pkgs; [ navidrome ];
}

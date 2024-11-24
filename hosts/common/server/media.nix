{ pkgs, ... }:

{
  services.navidrome = {
    enable = false;
    package = pkgs.unstable.navidrome;

    settings = {
      MusicFolder = "/run/media/kamwithk/Media/Music";
    };
  };
}

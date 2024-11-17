{ pkgs, ... }:

{
  services.navidrome = {
    enable = true;
    package = pkgs.unstable.navidrome;

    settings = {
      MusicFolder = "/run/media/kamwithk/Media/Music";
    };
  };
}

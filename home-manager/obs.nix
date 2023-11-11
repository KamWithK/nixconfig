{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    linuxPackages.v4l2loopback
    v4l-utils
  ];
}

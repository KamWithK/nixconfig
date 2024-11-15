{ pkgs, ... }:

{
  programs.obs-studio.enable = true;
  home.packages = with pkgs; [
    linuxPackages.v4l2loopback
    v4l-utils
  ];
}

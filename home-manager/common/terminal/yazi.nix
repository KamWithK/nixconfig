{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    poppler
    ffmpegthumbnailer
    imagemagick
  ];
}

{ pkgs, ... }:

{
  config.programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
  };

  config.home.file = {
    ".config/mpv/input.conf".source = ../../dotfiles/mpv/input.conf;
    ".config/mpv/mpv.conf".source = ../../dotfiles/mpv/mpv.conf;
  };
}

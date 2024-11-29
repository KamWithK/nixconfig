{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./mpv.nix
    ./obs.nix
    ./redshift.nix
  ];

  programs.zathura.enable = true;
  programs.feh.enable = true;
  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;
  services.flameshot.enable = false;

  services.avizo.enable = true;

  programs.spicetify.enable = true;

  home.packages = with pkgs; [
    playerctl
    pavucontrol
    swww

    xfce.thunar

    unstable.gnome-boxes

    discord-canary
    vesktop
    signal-desktop
    slack
    halloy
    fractal
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-desktopeditors
    # unstable.feishin

    unstable.qbittorrent
    nicotine-plus
    unstable.picard

    unstable.vintagestory
  ];
}

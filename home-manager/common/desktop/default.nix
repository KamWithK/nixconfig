{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./mpv.nix
    ./obs.nix
    ./redshift.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol

    xfce.thunar
    feh
    flameshot
    vdhcoapp

    gnome.gnome-boxes

    unstable.discord
    unstable.vesktop
    signal-desktop
    slack
    spotify
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-bin
    # unstable.feishin
    # sonixd

    qbittorrent
    nicotine-plus
    unstable.picard
  ];
}

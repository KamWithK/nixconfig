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
    avizo

    git-crypt

    xfce.thunar
    feh
    flameshot
    vdhcoapp

    gnome.gnome-boxes

    discord
    vesktop
    signal-desktop
    slack
    spotify
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-bin
    # unstable.feishin
    # sonixd

    unstable.qbittorrent
    nicotine-plus
    unstable.picard
  ];
}

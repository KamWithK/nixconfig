{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./mpv.nix
    ./obs.nix
    ./redshift.nix
  ];

  programs.zathura.enable = true;

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
    avizo

    git-crypt

    xfce.thunar
    feh
    flameshot

    gnome-boxes

    discord
    vesktop
    signal-desktop
    slack
    spotify
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-bin
    # feishin
    # sonixd

    qbittorrent
    nicotine-plus
    picard
  ];
}

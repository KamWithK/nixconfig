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

  home.packages = with pkgs; [
    playerctl
    pavucontrol

    xfce.thunar

    unstable.gnome-boxes

    discord
    vesktop
    signal-desktop
    slack
    spotify
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

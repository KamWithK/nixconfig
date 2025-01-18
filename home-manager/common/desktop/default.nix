{ pkgs, ... }:

{
  imports = [
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

  programs.btop.enable = true;

  programs.spicetify.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    };
  };

  home.packages = with pkgs; [
    playerctl
    pavucontrol
    simple-scan

    xfce.thunar

    gnome-boxes

    discord-canary
    signal-desktop
    slack
    halloy
    fractal
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-desktopeditors
    # feishin

    qbittorrent
    nicotine-plus
    picard

    # vintagestory
    prismlauncher
  ];
}

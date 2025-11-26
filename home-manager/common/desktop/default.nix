{ pkgs, ... }:

let
  archiveTool = [ "org.gnome.fileRoller.desktop" ];
in
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
      "application/zip" = archiveTool;
      "application/7z" = archiveTool;
      "application/rar" = archiveTool;
      "application/*rar" = archiveTool;
    };
  };

  home.packages = with pkgs; [
    playerctl
    pavucontrol
    simple-scan
    file-roller
    vlc
    localsend

    xfce.thunar

    gnome-boxes
    aws-workspaces

    discord-canary
    signal-desktop
    slack
    # calibre
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # onlyoffice-desktopeditors
    # feishin

    grayjay
    qbittorrent
    nicotine-plus
    picard
    yt-dlp

    lollypop

    # vintagestory
    # prismlauncher
  ];
}

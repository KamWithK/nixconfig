{ pkgs, ... }:

{

  home.packages = with pkgs; [
    firefox
    chromium
    discord
    slack
    spotify
    calibre

    xclip
    rofi-wayland
    networkmanagerapplet
    playerctl
    avizo
    feh
    flameshot

    nodejs
    unstable.go
    unstable.gopls
    unstable.atlas

    anki-bin
  ];

  # Enable git
  programs.git.enable = true;
}

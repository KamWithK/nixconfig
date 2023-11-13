{ pkgs, ... }:

{

  home.packages = with pkgs; [
    firefox
    unstable.chromium
    unstable.discord
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

  nixpkgs.config.environment.variables = {
    TERMINAL = "alacritty";
  };

  # Enable git
  programs.git.enable = true;
}

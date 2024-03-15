{ pkgs, ... }:

{

  home.packages = with pkgs; [
    xclip
    rofi-wayland
    networkmanagerapplet
    playerctl
    avizo
    xfce.thunar
    tree
    unp
    unrar
    peazip
    feh
    wget
    flameshot
    gparted

    unstable.mullvad-browser
    unstable.mullvad-closest

    android-studio
    flutter
  ];

  nixpkgs.config.environment.variables = {
    TERMINAL = "alacritty";
  };

  # Enable git
  programs.git.enable = true;
}

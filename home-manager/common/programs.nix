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
    peazip
    feh
    wget
    flameshot

    unstable.mullvad-browser
    unstable.mullvad-closest
  ];

  nixpkgs.config.environment.variables = {
    TERMINAL = "alacritty";
  };

  # Enable git
  programs.git.enable = true;
}

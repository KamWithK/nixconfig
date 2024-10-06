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
    feh
    wget
    flameshot

    gh
    # android-studio
  ];

  nixpkgs.config.environment.variables = {
    TERMINAL = "alacritty";
  };

  # Enable git
  programs.git = {
    enable = true;
    userName = "Kamron Bhavnagri";
    userEmail = "kamwithk@tuta.io";
  };
}

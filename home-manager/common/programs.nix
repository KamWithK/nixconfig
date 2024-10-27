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

  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  programs.alacritty.enable = true;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

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

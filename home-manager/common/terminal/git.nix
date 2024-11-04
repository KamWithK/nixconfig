{ pkgs, ... }:

{
  # Enable git
  programs.git = {
    enable = true;
    userName = "Kamron Bhavnagri";
    userEmail = "kamwithk@tuta.io";
  };

  home.packages = with pkgs; [ gh ];
}

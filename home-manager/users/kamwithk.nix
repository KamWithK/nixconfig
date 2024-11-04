{ outputs, pkgs, ... }:

{
  imports = [
    ../../hosts/common/stylix.nix
    ../common/terminal
    ../common/editor
    ../common/window_manager
    ../common/desktop
    ../common/browser
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [
      outputs.overlays.additions
      outputs.overlays.unstable-packages
      outputs.overlays.flake-inputs
    ];
  };
  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kamwithk";
  home.homeDirectory = "/home/kamwithk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

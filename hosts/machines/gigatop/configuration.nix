{ config, pkgs, lib, inputs, outputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common/pipewire.nix
    ../../common/x11.nix
    # ../../common/wayland.nix
    ../../common/locale.nix
    ../../common/fonts.nix
    ../../common/bluetooth.nix
    ../../common/virtual_devices.nix
    ../../common/vpn.nix
    ../../common/zerotier.nix
    ../../common/shell.nix
    ../../common/mounts.nix
    ../../common/hp_printer.nix
  ];

  # Source - https://github.com/Misterio77/nix-starter-configs/blob/main/standard/overlays/default.nix
  nixpkgs = {
    overlays = with outputs.overlays; [ additions unstable-packages ];
    config.allowUnfree = true;
  };
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Networking
  networking.hostName = "gigatop";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # Logitech Unifying Bolt
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kamwithk = {
    isNormalUser = true;
    description = "Kamron Bhavnagri";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
  };

  # Docker virtualisation
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "kamwithk" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
      home-manager

      killall
      parted

      alacritty
      helix
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

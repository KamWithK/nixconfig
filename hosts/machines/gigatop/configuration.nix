{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../common/pipewire.nix
    ../../common/x11.nix
    ../../common/wayland.nix
    ../../common/stylix.nix
    ../../common/locale.nix
    ../../common/fonts.nix
    ../../common/bluetooth.nix
    ../../common/virtual_devices.nix
    ../../common/hotspot.nix
    ../../common/printing.nix
    ../../common/vpn.nix
    ../../common/zerotier.nix
    ../../common/shell.nix
    ../../common/filesystems.nix
    ../../common/rgb.nix
    ../../common/steam.nix
    ../../common/server/networking.nix
    ../../common/server/media.nix
  ];

  # Source - https://github.com/Misterio77/nix-starter-configs/blob/main/standard/overlays/default.nix
  nixpkgs = {
    overlays = with inputs.self.overlays; [
      additions
    ];
    config.allowUnfree = true;
  };
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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

  # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];

        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/nix-collect-garbage";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  services.dbus.packages = [ pkgs.gcr ];

  # Logitech Unifying Bolt
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  programs.adb.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kamwithk = {
    isNormalUser = true;
    description = "Kamron Bhavnagri";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
      "adbuser"
      "libvirtd"
    ];
  };

  # Docker virtualisation
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "kamwithk" ];

  # KVM QEMU virtualivirtualisation
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    home-manager

    killall
    polkit_gnome

    helix
  ];

  # fileSystems."/mnt/Backup" = {
  #   device = "/dev/sda2";
  #   fsType = "auto";
  #   options = [
  #     "nosuid"
  #     "nodev"
  #     "nofail"
  #     "x-gvfs-show"
  #   ];
  # };

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
  system.stateVersion = "24.05"; # Did you read the comment?
}

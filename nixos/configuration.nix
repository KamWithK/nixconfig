{ config, pkgs, lib, inputs, outputs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

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
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "en_AU.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  # Specific locale defaults
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Mount Windows partition
  fileSystems."/mnt/Windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "auto";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };

  # Enable the X11 windowing system.
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    # libinput.enable = true; # touchpad support

    displayManager.sddm.enable = true;
    windowManager.bspwm.enable = true;
    # windowManager.hypr.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # hardware.opengl.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Logitech Unifying Bolt
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  sound.mediaKeys.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # File management
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kamwithk = {
    isNormalUser = true;
    description = "Kamron Bhavnagri";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # ~/.background-image loaded by default on x11
  services.xserver.desktopManager.wallpaper.mode = "fill";

  # Set default shells
  environment.binsh = "${pkgs.dash}/bin/dash";
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable virtual camera and audio
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];
  boot.kernelModules = [ "v4l2loopback" "snd-aloop" ];
  boot.extraModprobeConfig = "options v4l2loopback exclusive_caps=1 card_label='Virtual Camera'";

  # Docker virtualisation
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "kamwithk" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
      home-manager

      killall
      unzip
      parted
      ffmpeg
      tree

      alacritty
      helix
  ];

  # Custom fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    nerdfonts
    font-awesome
    google-fonts
    ipafont
    noto-fonts
    noto-fonts-cjk
  ];

  # Default fonts
  fonts.fontconfig.defaultFonts = {
   monospace = [
     "DejaVu Sans Mono"
     "Noto Sans JP"
     "Klee One Semibold"
   ];
   sansSerif = [
    "DejaVu Sans"
    "Noto Sans JP"
    "Klee One Semibold"
   ];
   serif = [
     "DejaVu Sans"
     "Noto Sans JP"
     "Klee One Semibold"
   ];
  };

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

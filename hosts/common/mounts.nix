{ ... }:
{
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # fileSystems."/mnt/Backup" = {
  #   device = "/dev/sda2";
  #   fsType = "auto";
  #   options = [ "nosuid" "nodev" "nofail" "x-gvfs-show" ];
  # };
}

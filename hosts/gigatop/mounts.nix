{ ... }:
{
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  fileSystems."/mnt/Windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "auto";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };
  fileSystems."/mnt/Media" = {
    device = "/dev/sda1";
    fsType = "auto";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };
  fileSystems."/mnt/Backup" = {
    device = "/dev/sda2";
    fsType = "auto";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show"];
  };
}

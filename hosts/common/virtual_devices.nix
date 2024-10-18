{ config, ... }:
{
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.extraModprobeConfig = "options v4l2loopback exclusive_caps=1 card_label='Virtual Camera'";
}

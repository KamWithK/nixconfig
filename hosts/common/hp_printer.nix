{ pkgs, ... }:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.startWhenNeeded = true;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [
    pkgs.sane-airscan
    pkgs.hplipWithPlugin
  ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
}

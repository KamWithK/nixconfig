{ pkgs, ... }:
{
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = false;
  services.mullvad-vpn.package = pkgs.unstable.mullvad-vpn;
}

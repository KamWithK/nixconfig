{ pkgs, ... }:
{
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = true;
  services.mullvad-vpn.package = pkgs.unstable.mullvad-vpn;
}

{ pkgs, ... }:
{
  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.nushell;
}

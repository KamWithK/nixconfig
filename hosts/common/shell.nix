{ pkgs, ... }:
{
  environment.binsh = "${pkgs.dash}/bin/dash";
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.nushell;
}

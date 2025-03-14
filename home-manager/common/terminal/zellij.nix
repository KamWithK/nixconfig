{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.zellij;
  };

  xdg.configFile."zellij/config.kdl" = {
    source = ../../../dotfiles/zellij.kdl;
  };

  home.shellAliases = {
    zd = "zellij --layout zellij.kdl";
  };
}

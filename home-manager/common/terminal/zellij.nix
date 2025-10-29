{ ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    exitShellOnExit = true;
  };

  xdg.configFile."zellij/config.kdl" = {
    source = ../../../dotfiles/zellij.kdl;
  };

  home.shellAliases = {
    zd = "zellij --layout zellij.kdl";
  };
}

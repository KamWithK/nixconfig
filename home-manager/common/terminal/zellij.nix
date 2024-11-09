{ config, pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.master.zellij;
  };

  xdg.configFile."zellij/config.kdl" = {
    source = ../../../dotfiles/zellij.kdl;
  };

  xdg.configFile."zellij/themes/default.kdl".text = with config.lib.stylix.colors.withHashtag; ''
    themes {
      default {
        bg "${base03}";
        fg "${base05}";
        red "${base01}";
        green "${base0B}";
        blue "${base0D}";
        yellow "${base0A}";
        magenta "${base0E}";
        orange "${base09}";
        cyan "${base0C}";
        black "${base00}";
        white "${base07}";
      }
    }
  '';

  home.shellAliases = {
    zd = "zellij --layout zellij.kdl";
  };
}

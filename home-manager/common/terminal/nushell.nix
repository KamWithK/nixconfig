{
  lib,
  config,
  pkgs,
  ...
}:

{
  programs.nushell = {
    enable = true;

    extraConfig = with pkgs.nushellPlugins; ''
      $env.config.show_banner = false
      pokeget random --hide-name

      def --env y [...args] {
        let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        yazi ...$args --cwd-file $tmp
        let cwd = (open $tmp)
        if $cwd != "" and $cwd != $env.PWD {
          cd $cwd
        }
        rm -fp $tmp
      }

      plugin add ${lib.getExe formats}
      plugin add ${lib.getExe query}
    '';

    environmentVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";

      DIRENV_WARN_TIMEOUT = "0";
    };

    shellAliases = config.home.shellAliases;
  };
}

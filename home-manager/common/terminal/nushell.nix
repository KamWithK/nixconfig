{ ... }:

{
  programs.nushell = {
    enable = true;

    extraConfig = ''
      $env.config.show_banner = false
      pokeget random --hide-name
    '';

    environmentVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";

      DIRENV_WARN_TIMEOUT = "0";
    };
  };
}

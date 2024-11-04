{ ... }:

{
  programs.nushell = {
    enable = true;

    extraConfig = ''
      $env.config.show_banner = false
      pokeget random --hide-name
    '';
  };

  programs.carapace.enable = true;
}

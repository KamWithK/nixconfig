{
  pkgs,
  options,
  config,
  lib,
  ...
}:
{
  stylix =
    {
      enable = true;
      polarity = "dark";
      fonts = {
        sizes = {
          popups = 15;
          desktop = 13;
          terminal = 13;
        };

        monospace = {
          package = pkgs.nerdfonts;
          name = "Hack Nerd Font Mono";
        };

        emoji = {
          package = pkgs.nerdfonts;
          name = "Symbols Nerd Font";
        };
      };

      # Themes from:
      # https://tinted-theming.github.io/base16-gallery/
      base16Scheme = "${pkgs.base16-schemes}/share/themes/stella.yaml";
      image = config.lib.stylix.pixel "base0A";
    }
    // lib.optionalAttrs (builtins.hasAttr "iconTheme" options.stylix) {
      iconTheme = {
        enable = true;
        package = pkgs.papirus-maia-icon-theme;

        dark = "Papirus-Dark-Maia";
        light = "Papirus-Light-Maia";
      };
    };
}

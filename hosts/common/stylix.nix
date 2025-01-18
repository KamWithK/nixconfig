{
  pkgs,
  options,
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
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font Mono";
        };

        emoji = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Nerd Font";
        };
      };

      # Themes from:
      # https://tinted-theming.github.io/base16-gallery/
      base16Scheme = "${pkgs.base16-schemes}/share/themes/stella.yaml";
      image = pkgs.fetchurl {
        url = "https://r4.wallpaperflare.com/wallpaper/64/184/28/anime-girls-balloon-women-sky-wallpaper-659852899b3ce30278d24f855a4395e8.jpg";
        sha256 = "sha256-ItLBw28sOvSRDoLPSkdudTpZyU5XaTW7UxNnsYfFXxU=";
      };
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

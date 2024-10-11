{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";

    # Themes from:
    # https://tinted-theming.github.io/base16-gallery/
    base16Scheme = "${pkgs.base16-schemes}/share/themes/stella.yaml";
    image = config.lib.stylix.pixel "base0A";
  };
}

{ config, ... }:

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      lsp.enable = true;
      theme = {
        enable = true;
        name = "base16";
        base16-colors = {
          inherit (config.lib.stylix.colors)
            base00
            base01
            base02
            base03
            base04
            base05
            base06
            base07
            base08
            base09
            base0A
            base0B
            base0C
            base0D
            base0E
            base0F
            ;
        };
      };
    };
  };
}

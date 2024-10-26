{ config, pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      lsp = {
        enable = true;
        lightbulb.enable = true;
      };
      treesitter.enable = true;

      languages = {
        enableLSP = true;
        enableTreesitter = true;

        nix = {
          enable = true;
          format.type = "nixfmt";
        };

        lua.enable = true;
        rust.enable = true;
        go.enable = true;
        html.enable = true;
        css.enable = true;
        tailwind.enable = true;
        ts = {
          enable = true;
          lsp.package = pkgs.nodePackages.typescript-language-server;
        };
        markdown.enable = true;
        svelte.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
      comments.comment-nvim.enable = true;

      git.gitsigns.enable = true;

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

      statusline.lualine.enable = true;

      telescope.enable = true;
      filetree.neo-tree.enable = true;
      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };
    };
  };
}

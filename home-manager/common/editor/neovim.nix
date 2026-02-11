{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      (lua.withPackages (luaPkgs: with luaPkgs; [ luarocks ]))
      python3
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      mini-nvim
      nvim-treesitter.withAllGrammars
    ];

    initLua = ''
      ${builtins.readFile ../../../dotfiles/nvim/init.lua}
    '';
  };

  xdg.configFile."nvim/after/colors/generated.lua".text =
    with config.lib.stylix.colors.withHashtag; ''
      require("mini.base16").setup({
        palette = {
          base00 = "${base00}", base01 = "${base01}", base02 = "${base02}", base03 = "${base03}",
          base04 = "${base04}", base05 = "${base05}", base06 = "${base06}", base07 = "${base07}",
          base08 = "${base08}", base09 = "${base09}", base0A = "${base0A}", base0B = "${base0B}",
          base0C = "${base0C}", base0D = "${base0D}", base0E = "${base0E}", base0F = "${base0F}"
        },
        plugins = {
          default = true,
        },
        use_cterm = true,
      })
      vim.g.colors_name = "generated"
    '';

  xdg.configFile."nvim/after" = {
    source = ../../../dotfiles/nvim/after;
    recursive = true;
  };
  xdg.configFile."nvim/plugin" = {
    source = ../../../dotfiles/nvim/plugin;
    recursive = true;
  };
  xdg.configFile."nvim/snippets" = {
    source = ../../../dotfiles/nvim/snippets;
    recursive = true;
  };
}

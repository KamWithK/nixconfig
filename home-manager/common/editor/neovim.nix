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

    extraLuaConfig = ''
      ${builtins.readFile ../../../dotfiles/nvim/init.lua}
    '';
  };

  xdg.configFile."nvim/colors/ministylix.lua".text = with config.lib.stylix.colors.withHashtag; ''
    require('mini.base16').setup({
      palette = {
        base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
        base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
        base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
        base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
      },
      plugins = {
        default = true,
      },
      use_cterm = true,
    })
    vim.g.colors_name = 'ministylix'
  '';
  xdg.configFile."nvim/lua/plugins/colorscheme.lua".text = ''
    return {
        "LazyVim/LazyVim",
        opts = {
          colorscheme = "ministylix",
        },
    }
  '';
  xdg.configFile."nvim/lua/plugins/mason.lua".text = ''
    return {
      { "williamboman/mason-lspconfig.nvim", enabled = false },
      { "williamboman/mason.nvim",           enabled = false },
    }
  '';
  xdg.configFile."nvim/lua/plugins/lspconfig.lua".text = ''
    return {
      "neovim/nvim-lspconfig",
      opts = {
        ensure_installed = {},

        servers = {
          jsonls = {},
          yamlls = {},
          lua_ls = {},
          nil_ls = {},
          nixd = {},
          gopls = {},
          clangd = {},
          rust_analyzer = {},
          ts_ls = {},
          vtsls = {},
          tailwindcss = {},
          svelte = {},
          dartls = {},
          slint_lsp = {
            cmd = {
              "slint-lsp",
              "--style", "cosmic-dark",
            },
          },
        }
      },
    }
  '';
  xdg.configFile."nvim/after/queries/rust/injections.scm".source =
    ../../../dotfiles/nvim/rust_injections.scm;

  xdg.configFile."nvim/lua/config" = {
    source = ../../../dotfiles/nvim/config;
    recursive = true;
  };
  xdg.configFile."nvim/lua/plugins" = {
    source = ../../../dotfiles/nvim/plugins;
    recursive = true;
  };
}

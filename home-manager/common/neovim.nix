{ config, inputs, ... }:
let
  utils = inputs.nixCats.utils;
in
{
  imports = [ inputs.nixCats.homeModule ];
  config = {
    # this value, nixCats is the defaultPackageName you pass to mkNixosModules
    # it will be the namespace for your options.
    nixCats = {
      # these are some of the options. For the rest see
      # :help nixCats.flake.outputs.utils.mkNixosModules
      # you do not need to use every option here, anything you do not define
      # will be pulled from the flake instead.
      enable = true;
      nixpkgs_version = inputs.nixos-unstable;

      # this will add the overlays from ./overlays and also,
      # add any plugins in inputs named "plugins-pluginName" to pkgs.neovimPlugins
      # It will not apply to overall system, just nixCats.
      addOverlays = # (import ./overlays inputs) ++
        [ (utils.standardPluginOverlay inputs) ];
      packageNames = [ "neovim" ];

      luaPath = "${../../dotfiles/neovim}";
      # you could also import lua from the flake though, by not including this.

      # categoryDefinitions.replace will replace the whole categoryDefinitions with a new one
      categoryDefinitions.replace = (
        {
          pkgs,
          settings,
          categories,
          name,
          ...
        }@packageDef:
        {
          lspsAndRuntimeDeps = {
            # some categories of stuff.
            general = with pkgs; [
              universal-ctags
              ripgrep
              fd
            ];
            # these names are arbitrary.
            lint = with pkgs; [ ];
            # but you can choose which ones you want
            # per nvim package you export
            debug = with pkgs; {
              go = [ delve ];
            };
            go = with pkgs; [
              gopls
              gotools
              go-tools
              gccgo
            ];
            # and easily check if they are included in lua
            format = with pkgs; [ ];
            neonixdev = {
              # also you can do this.
              inherit (pkgs) nix-doc lua-language-server nixd;
              # and each will be its own sub category
            };
          };

          startupPlugins = {
            debug = with pkgs.vimPlugins; [ nvim-nio ];
            general = with pkgs.vimPlugins; {
              # you can make subcategories!!!
              # (always isnt a special name, just the one I chose for this subcategory)
              always = [
                lze
                vim-repeat
                plenary-nvim
                mini-nvim
              ];
              extra = [
                oil-nvim
                nvim-web-devicons
              ];
            };
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          # or a tool for organizing this like lze or lz.n!
          # to get the name packadd expects, use the
          # `:NixCats pawsible` command to see them all
          optionalPlugins = {
            debug = utils.catsWithDefault categories [ "debug" ] (with pkgs.vimPlugins; [
              nvim-dap
              nvim-dap-ui
              nvim-dap-virtual-text
            ]) (with pkgs.vimPlugins; { go = [ nvim-dap-go ]; });
            lint = with pkgs.vimPlugins; [ nvim-lint ];
            format = with pkgs.vimPlugins; [ conform-nvim ];
            markdown = with pkgs.vimPlugins; [ markdown-preview-nvim ];
            neonixdev = with pkgs.vimPlugins; [ lazydev-nvim ];
            general = {
              cmp = with pkgs.vimPlugins; [
                # cmp stuff
                nvim-cmp
                luasnip
                friendly-snippets
                cmp_luasnip
                cmp-buffer
                cmp-path
                cmp-nvim-lua
                cmp-nvim-lsp
                cmp-cmdline
                cmp-nvim-lsp-signature-help
                cmp-cmdline-history
                lspkind-nvim
              ];
              treesitter = with pkgs.vimPlugins; [
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                # This is for if you only want some of the grammars
                # (nvim-treesitter.withPlugins (
                #   plugins: with plugins; [
                #     nix
                #     lua
                #   ]
                # ))
              ];
              telescope = with pkgs.vimPlugins; [
                telescope-fzf-native-nvim
                telescope-ui-select-nvim
                telescope-nvim
              ];
              always = with pkgs.vimPlugins; [
                nvim-lspconfig
                lualine-nvim
                gitsigns-nvim
                vim-sleuth
                vim-fugitive
                vim-rhubarb
                nvim-surround
              ];
              extra = with pkgs.vimPlugins; [
                fidget-nvim
                # lualine-lsp-progress
                which-key-nvim
                comment-nvim
                undotree
                indent-blankline-nvim
                vim-startuptime
                # If it was included in your flake inputs as plugins-hlargs,
                # this would be how to add that plugin in your config.
                # pkgs.neovimPlugins.hlargs
              ];
            };
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs; [
              # <- this would be included if any of the subcategories of general are
              # libgit2
            ];
          };

          # environmentVariables:
          # this section is for environmentVariables that should be available
          # at RUN TIME for plugins. Will be available to path within neovim terminal
          environmentVariables = { };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = { };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages

          # get the path to this python environment
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          extraPython3Packages = {
            test = (_: [ ]);
          };
          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };
        }
      );

      # see :help nixCats.flake.outputs.packageDefinitions
      packages = {
        # These are the names of your packages
        # you can include as many as you wish.
        neovim =
          { pkgs, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              wrapRc = true;
              aliases = [
                "vi"
                "vim"
                "nvim"
              ];
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              markdown = true;
              general = true;
              lint = true;
              format = true;
              neonixdev = true;
              nixdExtras.nixpkgs = inputs.nixos-unstable.outPath;
              base16-colors = builtins.mapAttrs (k: v: "#" + v) {
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
    };
  };
}

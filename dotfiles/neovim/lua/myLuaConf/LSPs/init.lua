local servers = {}
if nixCats('neonixdev') then
  servers.lua_ls = {
    Lua = {
      formatters = {
        ignoreComments = true,
      },
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { 'nixCats' },
        disable = { 'missing-fields' },
      },
    },
    telemetry = { enabled = false },
    filetypes = { 'lua' },
  }
  servers.nixd = {
    nixd = {
      nixpkgs = {
        -- nixd requires some configuration in flake based configs.
        -- luckily, the nixCats plugin is here to pass whatever we need!
        expr = [[import (builtins.getFlake "]] .. nixCats("nixdExtras.nixpkgs") .. [[") { }   ]],
      },
      formatting = {
        command = { "nixfmt" }
      },
      diagnostic = {
        suppress = {
          "sema-escaping-with"
        }
      }
    }
  }
  -- If you integrated with your system flake,
  -- you should pass inputs.self.outPath as nixdExtras.flake-path
  -- that way it will ALWAYS work, regardless
  -- of where your config actually was.
  -- otherwise flake-path could be an absolute path to your system flake, or nil or false
  if nixCats("nixdExtras.flake-path") and nixCats("nixdExtras.systemCFGname") and nixCats("nixdExtras.homeCFGname") then
    servers.nixd.nixd.options = {
      -- (builtins.getFlake "<path_to_system_flake>").nixosConfigurations."<name>".options
      nixos = {
        expr = [[(builtins.getFlake "]] ..
          nixCats("nixdExtras.flake-path") ..  [[").nixosConfigurations."]] ..
          nixCats("nixdExtras.systemCFGname") .. [[".options]]
      },
      -- (builtins.getFlake "<path_to_system_flake>").homeConfigurations."<name>".options
      ["home-manager"] = {
        expr = [[(builtins.getFlake "]] ..
          nixCats("nixdExtras.flake-path") .. [[").homeConfigurations."]] ..
          nixCats("nixdExtras.homeCFGname") .. [[".options]]
      }
    }
  end
end

if nixCats('go') then
  servers.gopls = {}
end

--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--  All of them are listed in https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--  You may do the same thing with cmd

-- servers.clangd = {},
-- servers.gopls = {},
-- servers.pyright = {},
-- servers.rust_analyzer = {},
-- servers.tsserver = {},
-- servers.html = { filetypes = { 'html', 'twig', 'hbs'} },

require('lze').load {
  {
    "nvim-lspconfig",
    event = "FileType",
    after = function(plugin)
      for server_name, cfg in pairs(servers) do
        require('lspconfig')[server_name].setup({
          capabilities = require('myLuaConf.LSPs.caps-on_attach').get_capabilities(server_name),
          -- this line is interchangeable with the above LspAttach autocommand
          on_attach = require('myLuaConf.LSPs.caps-on_attach').on_attach,
          settings = cfg,
          filetypes = (cfg or {}).filetypes,
          cmd = (cfg or {}).cmd,
          root_pattern = (cfg or {}).root_pattern,
        })
      end
    end,
  }
}

local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    opts.servers.eslint = {}

    opts.servers.marksman = {
      settings = {
        markdown = {
          lint = {
            config = {
              MD013 = false,
            },
          },
        },
      },
    }

    opts.servers.stylelint_lsp = {
      settings = {
        stylelint = {
          -- This is the crucial part to enable formatting
          format = {
            enable = true,
          },
        },
      },
    }

    -- opts.servers.angularls = {
    --   filetypes = { "html", "htmlangular" },
    --   on_attach = function(client)
    --     client.server_capabilities.renameProvider = false
    --   end,
    -- }

    -- LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
    --   {
    --     name = "@angular/language-server",
    --     location = LazyVim.get_pkg_path("angular-language-server", "node_modules/@angular/language-server"),
    --     enableForWorkspaceTypeScriptVersions = false,
    --   },
    -- })
  end,
  -- opts = {
  --   servers = {
  --     eslint = {},
  --     marksman = {
  --       settings = {
  --         markdown = {
  --           lint = {
  --             config = {
  --               MD013 = false,
  --             },
  --           },
  --         },
  --       },
  --     },
  --     stylelint_lsp = {
  --       settings = {
  --         stylelint = {
  --           -- This is the crucial part to enable formatting
  --           format = {
  --             enable = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  setup = {
    eslint = function()
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = true
        elseif client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end)
    end,
  },
}

-- return {
--   "neovim/nvim-lspconfig",
--   opts = function(_, opts)
--
--     -- Option 1: completely disable the standalone angularls server to avoid duplicates.
--     -- This leaves Angular support to the vtsls tsserver plugin below.
--
--     -- Option 2 (alternative): restrict angularls to HTML templates only.
--     -- This avoids attaching angularls to TypeScript files while still providing
--     -- diagnostics for Angular templates. Uncomment to use this instead of
--     -- disabling the server entirely.
--     -- opts.servers.angularls = {
--     --   filetypes = { "html", "htmlangular" },
--     --   -- You can also disable certain capabilities to reduce overlap:
--     --   -- on_attach = function(client)
--     --   --   client.server_capabilities.referencesProvider = false
--     --   --   client.server_capabilities.definitionProvider = false
--     --   --   client.server_capabilities.renameProvider = false
--     --   -- end,
--     -- }
--
--     -- Extend vtsls to load the Angular Language Service as a tsserver plugin.
--     -- This plugin enhances TypeScript server with Angular-specific features,
--     -- including cross-file navigation and template diagnostics. It is the
--     -- recommended setup in LazyVim's Angular extra【540586147282318†L184-L206】.
--     local util = require("lazyvim.util")
--     util.extend(
--       opts.servers.vtsls,
--       "settings.vtsls.tsserver.globalPlugins",
--       {
--         {
--           name = "@angular/language-server",
--           location = util.get_pkg_path(
--             "angular-language-server",
--             "/node_modules/@angular/language-server"
--           ),
--           -- When false (default in LazyVim), the plugin uses its own TypeScript
--           -- version. Set to true to use your workspace TypeScript version if
--           -- you run into version mismatches.
--           enableForWorkspaceTypeScriptVersions = false,
--         },
--       }
--     )
--   end,

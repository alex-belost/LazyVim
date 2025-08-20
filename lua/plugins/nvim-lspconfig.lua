local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      marksman = {
        settings = {
          markdown = {
            lint = {
              config = {
                MD013 = false,
              },
            },
          },
        },
      },
      stylelint_lsp = {
        settings = {
          stylelint = {
            -- This is the crucial part to enable formatting
            format = {
              enable = true,
            },
          },
        },
      },
    },
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
  },
}

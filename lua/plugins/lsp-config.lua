local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",

  -- other settings removed for brevity
  opts = {
    servers = {
      eslint = {
        -- root_dir = util.root_pattern(
        --   ".eslintrc",
        --   ".eslintrc.js",
        --   ".eslintrc.cjs",
        --   ".eslintrc.yaml",
        --   ".eslintrc.yml",
        --   ".eslintrc.json"
        --   -- Disabled to prevent "No ESLint configuration found" exceptions
        --   -- 'package.json',
        -- ),
        -- settings = {
        --   -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
        --   workingDirectories = { mode = "auto" },
        --   experimental = {
        --     -- allows to use flat config format
        --     useFlatConfig = true,
        --   },
        -- },
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

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    opts.servers.eslint = {
      settings = {
        format = { enable = true },
        workingDirectory = { mode = "auto" },
      },
    }

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

    opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "className\\s*[:=]\\s*[\"'`]([^\"'`]*)[\"'`]" },
              { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
              { "classNames\\s*:\\s*{([^}]*)}", "[\"'`]([^\"'`]*)[\"'`]" },
            },
          },
        },
      },
    })

    opts.setup = opts.setup or {}

    opts.setup.eslint = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and (client.name == "tsserver" or client.name == "vtsls") then
            client.server_capabilities.documentFormattingProvider = false
          end
        end,
      })
    end
  end,
}

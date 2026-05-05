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

    -- mason-lspconfig still maps `stylelint_lsp` to the deprecated `stylelint-lsp`
    -- package. Skip auto-install here; the binary is provided by the
    -- `stylelint-language-server` Mason package (see plugins/mason.lua).
    opts.servers.stylelint_lsp = {
      mason = false,
      filetypes = { "css", "scss", "less", "sass", "postcss" },
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
  end,
}

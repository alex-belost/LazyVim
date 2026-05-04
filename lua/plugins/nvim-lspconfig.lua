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

    opts.servers.stylelint_lsp = {
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

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local prettier = { "prettierd", "prettier", stop_after_first = true }

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        markdown = prettier,
        html = prettier,
        css = prettier,
        scss = prettier,
        json = prettier,
        jsonc = prettier,
        yaml = prettier,
      })

      opts.default_format_opts = vim.tbl_deep_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 3000,
        async = true,
        lsp_format = "fallback",
      })
    end,
  },
}

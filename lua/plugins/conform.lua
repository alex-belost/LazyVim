return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        markdown = { "prettier" },
        html = { "prettier" },
      })

      opts.default_format_opts = vim.tbl_deep_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 3000,
        lsp_format = "fallback",
      })
    end,
  },
}

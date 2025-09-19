return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- This will ensure that for the specified filetypes,
      -- conform.nvim uses stylelint, overriding any other defaults like prettier.
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        css = { "stylelint" },
        scss = { "stylelint" },
        less = { "stylelint" },
        postcss = { "stylelint" },
        markdown = { "prettier" },
        html = { "prettier" },
      })

      opts.formatters = opts.formatters or {}
    end,
  },
}

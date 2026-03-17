return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      cascade = {
        mode = "diagnostics",
        filter = function(items)
          local severity = vim.diagnostic.severity.HINT
          for _, item in ipairs(items) do
            severity = math.min(severity, item.severity)
          end
          return vim.tbl_filter(function(item)
            return item.severity == severity
          end, items)
        end,
      },
      symbols = {
        win = { position = "right" },
      },
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>xc", "<cmd>Trouble cascade toggle<cr>", desc = "Cascade Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false win.position=right<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / References (Trouble)" },
  },
}

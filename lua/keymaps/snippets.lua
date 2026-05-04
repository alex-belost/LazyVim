vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_snippets_js", { clear = true }),
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function(args)
    vim.keymap.set("x", "<leader>cnl", function()
      require("util.snippets.log").console_log_below_selection()
    end, { buffer = args.buf, desc = "Console.log selection below" })
  end,
})

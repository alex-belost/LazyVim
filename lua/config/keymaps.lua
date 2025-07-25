-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

vim.keymap.set("n", "<leader>bf", function()
  Snacks.explorer.reveal()
end, { silent = true, desc = "Find current buffer" })

vim.keymap.set("n", "<leader>uo", function()
  local value = vim.fn.input("Enter shiftwidth value: ")

  if tonumber(value) then
    vim.cmd("set shiftwidth=" .. value)
  else
    print("Invalid value: Please enter a numeric value")
  end
end, { silent = true, desc = "Set shiftwidth" })

vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>ce", function()
  vim.lsp.buf.format({
    -- filter = function(client)
    --   return client.name == "eslint"
    -- end,
  })
end, { desc = "Lsp Format" })

vim.keymap.set("v", "<leader>cf", function()
  require("conform").format({
    lsp_fallback = false,
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
  })
end, { desc = "Range format code" })

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format()
end, { desc = "Format code" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

vim.keymap.set(
  "n",
  "<leader>bf",
  "<cmd>Neotree focus filesystem left reveal<cr>",
  { silent = true, desc = "Find current buffer" }
)

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


vim.api.nvim_create_user_command("FormatBuffer", function()
  local clients = vim.lsp.get_active_clients()
  local has_eslint = false

  for _, client in ipairs(clients) do
    if client.name == "eslint" then
      has_eslint = true
    end
  end

  if has_eslint then
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "eslint"
      end,
    })
  else
    vim.cmd("ConformFormat") -- Запуск Conform, если eslint недоступен
  end
end, {})
vim.keymap.set("n", "<leader>ce", "<cmd>FormatBuffer<cr>", { desc = "Lsp Format" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

vim.keymap.set("n", "<leader>bf", function()
  Snacks.explorer.reveal()
end, { silent = true, desc = "Find current buffer" })

vim.keymap.set("n", "<leader>uo", require("util.options").shiftwidth_prompt, { silent = true, desc = "Set shiftwidth" })

vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>ce", "<cmd>LspEslintFixAll<cr>", { desc = "Eslint Fix All" })
vim.keymap.set("n", "<leader>cf", require("util.format").buffer_format, { desc = "Format" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
-- Move between windows with ctrl + arrow keys
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move to lower split" })

vim.keymap.set("n", "<C-S-Left>", ":vertical resize +5<CR>", { desc = "Resize left", silent = true })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize -5<CR>", { desc = "Resize right", silent = true })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { desc = "Resize up", silent = true })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { desc = "Resize down", silent = true })

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers", silent = true })

vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape", silent = true })

require("keymaps.snippets")

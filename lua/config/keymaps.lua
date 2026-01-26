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

-- Move between windows with ctrl + arrow keys
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move to lower split" })

vim.keymap.set("n", "<C-S-Left>", ":vertical resize +5<CR>", { desc = "Move to left split", silent = true })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize -5<CR>", { desc = "Move to right split", silent = true })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { desc = "Move to upper split", silent = true })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { desc = "Move to lower split", silent = true })

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers", silent = true })

vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape", silent = true })

vim.keymap.set({ "x", "o" }, "af", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Function" })

vim.keymap.set({ "x", "o" }, "if", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Function" })

vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Class" })

vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Class" })

vim.keymap.set({ "x", "o" }, "as", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end, { desc = "Scope" })

vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap Inner Parameter" })

vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
end, { desc = "Swap Outer Parameter" })

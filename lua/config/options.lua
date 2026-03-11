-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded" },
})

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Let ESLint LSP own JS/TS formatting by stripping the formatting capability from the TS server.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_disable_ts_formatting", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and (client.name == "tsserver" or client.name == "vtsls") then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})

local M = {}

local js_ft = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }

function M.buffer_format()
  if js_ft[vim.bo.filetype] and vim.fn.exists(":LspEslintFixAll") == 2 then
    vim.cmd("LspEslintFixAll")
  else
    LazyVim.format({ force = true })
  end
end

return M

local M = {}

function M.console_log_below_selection()
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  local lines = vim.fn.getregion(s, e, { type = vim.fn.mode() })
  local selection = vim.trim((table.concat(lines, " "):gsub("%s+", " ")))
  if selection == "" then
    return
  end
  local label = selection:gsub("['\"]", "")

  local end_row = math.max(s[2], e[2])
  local indent = vim.fn.indent(end_row)
  local new_row = end_row + 1
  local new_line = string.rep(" ", indent) .. ("console.log('%s:%d', %s);"):format(label, new_row, selection)

  vim.api.nvim_buf_set_lines(0, end_row, end_row, false, { new_line })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, { new_row, indent })
  end)
end

return M

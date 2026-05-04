local M = {}

function M.console_log_below_selection()
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then
    s, e = e, s
  end

  local lines = vim.api.nvim_buf_get_text(0, s[2] - 1, s[3] - 1, e[2] - 1, e[3], {})
  local selection = vim.trim((table.concat(lines, " "):gsub("%s+", " ")))
  if selection == "" then
    return
  end
  local label = selection:gsub("['\"]", "")

  local indent = vim.fn.indent(e[2])
  local new_row = e[2] + 1
  local new_line = string.rep(" ", indent) .. ("console.log('%s:%d', %s);"):format(label, new_row, selection)

  vim.api.nvim_buf_set_lines(0, e[2], e[2], false, { new_line })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, { new_row, indent })
  end)
end

return M

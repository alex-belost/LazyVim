local M = {}

function M.shiftwidth_prompt()
  local value = tonumber(vim.fn.input("Enter shiftwidth value: "))

  if value then
    vim.bo.shiftwidth = value
  else
    vim.notify("Invalid value: please enter a numeric value", vim.log.levels.ERROR)
  end
end

return M

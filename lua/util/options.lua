local M = {}

function M.shiftwidth_prompt()
  local value = vim.fn.input("Enter shiftwidth value: ")

  if tonumber(value) then
    vim.cmd("set shiftwidth=" .. value)
  else
    print("Invalid value: Please enter a numeric value")
  end
end

return M

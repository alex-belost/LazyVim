return {
  "sindrets/diffview.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: File History" },
    { "<leader>dx", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
    {
      "<leader>db",
      function()
        require("snacks").picker("git_branches", {
          title = "Diffview: Branches",
          prompt = "Select a branch:",
          confirm = function(picker)
            local selection = picker.list:current()
            if selection then
              vim.cmd("DiffviewOpen " .. selection.branch)
            end
          end,
        })
      end,
      desc = "Diffview: Branches",
    },
    { "<leader>dl", "<cmd>DiffviewLog<cr>", desc = "Diffview: Log" },
    { "<leader>ds", "<cmd>DiffviewOpen --staged<cr>", desc = "Diffview: Staged" },
  },
}

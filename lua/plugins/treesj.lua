return {
  "Wansmer/treesj",
  keys = {
    { "<space>m", false },
    { "<space>j", false },
    { "<space>s", false },
    { "<leader>ct", "<cmd>TSJToggle<cr>", desc = "Toggle node" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Function outer" },
          ["if"] = { query = "@function.inner", desc = "Function inner" },
          ["ac"] = { query = "@class.outer", desc = "Class outer" },
          ["ic"] = { query = "@class.inner", desc = "Class inner" },
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Scope" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
        },
        swap_previous = {
          ["<leader>A"] = { query = "@parameter.inner", desc = "Swap prev parameter" },
        },
      },
    },
  },
}

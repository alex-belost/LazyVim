return {
  "folke/snacks.nvim",
  opts = {
    explorer = {},
    picker = {
      sources = {
        explorer = {
          hidden = true,
          follow_file = false,
          win = {
            list = {
              keys = {
                ["<BS>"] = { "explorer_up", desc = "Explorer up" },
                ["l"] = { "confirm", desc = "Open / Edit" },
                ["h"] = { "explorer_close", desc = "Close directory" },
                ["a"] = { "explorer_add", desc = "Add" },
                ["d"] = { "explorer_del", desc = "Delete" },
                ["r"] = { "explorer_rename", desc = "Rename" },
                ["c"] = { "explorer_copy", desc = "" },
                ["m"] = { "explorer_move", desc = "Explorer move" },
                ["o"] = { "explorer_open", desc = "System open" },
                ["P"] = { "toggle_preview", desc = "Toggle preview" },
                ["y"] = { "explorer_yank", mode = { "n", "x" }, desc = "Explorer yank" },
                ["p"] = { "explorer_paste", desc = "Paste" },
                ["u"] = { "explorer_update", desc = "Update" },
                ["<c-c>"] = { "tcd", desc = "tcd" },
                ["<leader>/"] = { "picker_grep", desc = "Find" },
                ["<c-t>"] = { "terminal", desc = "Terminal" },
                ["."] = { "explorer_focus", desc = "Focus" },
                ["I"] = { "toggle_ignored", desc = "Ignored toggle" },
                ["H"] = { "toggle_hidden", desc = "Hidden toggle" },
                ["Z"] = { "explorer_close_all", desc = "Close all" },
                ["]g"] = { "explorer_git_next", desc = "Git next" },
                ["[g"] = { "explorer_git_prev", desc = "Git prev" },
                ["]d"] = { "explorer_diagnostic_next", desc = "Diagnostic_next" },
                ["[d"] = { "explorer_diagnostic_prev", desc = "Diagnostic prev" },
                ["]w"] = { "explorer_warn_next", desc = "Warn next" },
                ["[w"] = { "explorer_warn_prev", desc = "Warn prev" },
                ["]e"] = { "explorer_error_next", desc = "Error next" },
                ["[e"] = { "explorer_error_prev", desc = "Error prev" },
              },
            },
          },
        },
      },
    },
  },
}

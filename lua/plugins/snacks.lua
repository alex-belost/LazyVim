local oil = require("oil")

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- Actions table is not needed for this approach
    explorer = {},
    picker = {
      enabled = true,
      sources = {
        ---@class snacks.picker.explorer.Config: snacks.picker.files.Config|{}
        ---@field follow_file? boolean follow the file from the current buffer
        ---@field tree? boolean show the file tree (default: true)
        ---@field git_status? boolean show git status (default: true)
        ---@field git_status_open? boolean show recursive git status for open directories
        ---@field git_untracked? boolean needed to show untracked git status
        ---@field diagnostics? boolean show diagnostics
        ---@field diagnostics_open? boolean show recursive diagnostics for open directories
        ---@field watch? boolean watch for file changes
        ---@field exclude? string[] exclude glob patterns
        ---@field include? string[] include glob patterns. These take precedence over `exclude`, `ignored` and `hidden`
        grep = {
          cmd = { "rg", "--vimgrep", "--no-heading", "--smart-case" },
        },
        explorer = {
          hidden = true,
          follow_file = true,
          actions = {
            open_in_oil = {
              action = function(_, item)
                if not item or not item.file then
                  return
                end

                local dir

                if vim.fn.isdirectory(item.file) == 1 then
                  dir = item.file
                else
                  dir = vim.fn.fnamemodify(item.file, ":p:h")
                end

                oil.open(dir)
              end,
            },
            yank_path_part = function(picker, item)
              local util = require("snacks.picker.util")
              local cur = item

              if not cur then
                local selected = picker:selected({ fallback = true })
                cur = selected and selected[1] or nil
              end

              if not cur then
                return
              end

              local path = util.path(cur) or ""
              local root = picker:cwd() or vim.fn.getcwd()

              local function rel(p)
                if p and root and p:find(root .. "/", 1, true) == 1 then
                  return p:sub(#root + 2)
                end
                return p
              end

              local dir = vim.fs.dirname(path)
              local entries = {
                { title = "Full => " .. path, text = path },
                { title = "Relative => " .. rel(path), text = rel(path) },
                { title = "Dir => " .. rel(dir), text = rel(dir) },
                { title = "File name => " .. vim.fs.basename(path), text = vim.fs.basename(path) },
                { title = "Dir name => " .. vim.fs.basename(dir), text = vim.fs.basename(dir) },
              }

              for i, entry in ipairs(entries) do
                entry.idx = i
              end

              vim.ui.select(entries, {
                prompt = "Yank Path",

                format_item = function(entry)
                  return entry.title
                end,
              }, function(choice)
                if choice then
                  local reg = (vim.v.register ~= "" and vim.v.register) or "+"
                  vim.fn.setreg(reg, choice.text, "l")
                  require("snacks").notify.info("Скопировано: " .. choice.text)
                end
              end)
            end,
          },
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
                ["<leader>fo"] = {
                  "open_in_oil",
                  desc = "Notify path and open Oil",
                },
                ["Y"] = { "yank_path_part", mode = { "n" }, desc = "Yank path part" },
                ["."] = { "explorer_focus", desc = "Focus" },
                ["I"] = { "toggle_ignored", desc = "Ignored toggle" },
                ["H"] = { "toggle_hidden", desc = "Hidden toggle" },
                ["Z"] = { "explorer_close_all", desc = "Close all" },
                ["]g]"] = { "explorer_git_next", desc = "Git next" },
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

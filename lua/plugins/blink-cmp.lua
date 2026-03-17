return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          return { "cmdline" }
        end,
      },
    },
  },
}

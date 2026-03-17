return {
  {
    "saghen/blink.pairs",
    version = "*",
    dependencies = { "saghen/blink.download" },
    event = "InsertEnter",
    opts = {},
  },
  {
    "saghen/blink.indent",
    version = "*",
    event = "BufReadPost",
    opts = {
      scope = { enabled = true },
    },
  },
}

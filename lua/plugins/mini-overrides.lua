return {
  {
    "nvim-mini/mini.ai",
    opts = function(_, opts)
      opts.custom_textobjects = opts.custom_textobjects or {}
      -- Fix: override 't' (tag) to use native Vim tag text object
      -- mini.ai breaks `vat`/`vit` for HTML/JSX tags
      opts.custom_textobjects.t = false
    end,
  },
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
}

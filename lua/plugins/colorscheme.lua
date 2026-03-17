return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        blink_cmp = true,
        dashboard = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        markdown = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = { enabled = true },
        noice = true,
        notify = true,
        nvim_surround = true,
        semantic_tokens = true,
        snacks = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  -- { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

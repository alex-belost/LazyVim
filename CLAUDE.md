# CLAUDE.md — LazyVim Neovim Configuration

This is a personal [LazyVim](https://www.lazyvim.org/) Neovim configuration. It extends LazyVim defaults with custom plugins, keymaps, and LSP/formatter settings.

---

## Repository Structure

```
.
├── init.lua                  # Entry point — bootstraps lua/config/lazy.lua
├── lazyvim.json              # LazyVim extras (managed by LazyVim UI)
├── lazy-lock.json            # Plugin lockfile (commit after :Lazy update)
├── stylua.toml               # StyLua formatter config
├── .neoconf.json             # Project-level neoconf (lua_ls enabled)
└── lua/
    ├── config/
    │   ├── lazy.lua          # lazy.nvim bootstrap and setup
    │   ├── options.lua       # vim options overrides
    │   ├── keymaps.lua       # custom keymaps
    │   └── autocmds.lua      # custom autocommands (currently empty)
    └── plugins/              # Each file returns a lazy.nvim plugin spec
        ├── bqf.lua
        ├── colorscheme.lua
        ├── conform.lua
        ├── diffview.lua
        ├── disable-plugins.lua
        ├── example.lua       # Reference only — skipped at load time
        ├── flash.lua
        ├── marks.lua
        ├── numbertoggle.lua
        ├── nvim-lspconfig.lua
        ├── nvim-surround.lua
        ├── oil.lua
        ├── snacks.lua
        ├── tmux-navigator.lua
        └── treesj.lua
```

---

## How Plugins Are Loaded

- `init.lua` calls `require("config.lazy")`.
- `lua/config/lazy.lua` bootstraps `lazy.nvim`, then loads:
  1. `LazyVim/LazyVim` and all its built-in plugins.
  2. Every spec file under `lua/plugins/` automatically.
- Plugin files **return a table** (or a list of tables) that lazy.nvim merges with the parent spec. Use `opts = function(_, opts) ... end` to extend existing options rather than replace them.
- `example.lua` contains `if true then return {} end` at the top — it is intentionally inert and serves only as a reference template.

---

## LazyVim Extras (lazyvim.json)

Managed via `:LazyExtras`. Currently enabled:

| Extra | Purpose |
|---|---|
| `coding.yanky` | Enhanced yank/paste |
| `editor.inc-rename` | Incremental LSP rename |
| `formatting.prettier` | Prettier formatter integration |
| `lang.angular` | Angular language support |
| `lang.git` | Git tooling |
| `lang.json` | JSON LSP + Treesitter |
| `lang.markdown` | Markdown LSP + Treesitter |
| `lang.prisma` | Prisma schema support |
| `lang.tailwind` | TailwindCSS LSP |
| `lang.toml` | TOML support |
| `lang.typescript` | TypeScript/vtsls |
| `lang.vue` | Vue support |
| `lang.yaml` | YAML support |
| `linting.eslint` | ESLint linting |

Do **not** manually edit `lazyvim.json` — use `:LazyExtras` inside Neovim.

---

## Core Options (lua/config/options.lua)

| Option | Value | Note |
|---|---|---|
| `vim.g.autoformat` | `false` | Autoformat on save disabled globally |
| `vim.opt.spell` | `true` | Spell checking enabled |

---

## Custom Keymaps (lua/config/keymaps.lua)

### Deleted LazyVim defaults
| Key | Reason |
|---|---|
| `<S-h>` | Removed (was prev buffer) |
| `<S-l>` | Removed (was next buffer) |

### Buffer navigation
| Key | Mode | Action |
|---|---|---|
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<leader><space>` | n | Snacks buffer picker |

### Window management
| Key | Action |
|---|---|
| `<C-Left/Right/Up/Down>` | Navigate between splits |
| `<C-S-Left/Right/Up/Down>` | Resize splits by 5 |

### File navigation
| Key | Action |
|---|---|
| `<leader>bf` | Reveal current buffer in Snacks explorer |
| `<leader>fo` | Open Oil in current buffer's directory |

### LSP / formatting
| Key | Action |
|---|---|
| `<leader>ce` | LSP format current buffer |
| `<leader>uo` | Prompt to set `shiftwidth` |

### Treesitter text objects (visual / operator-pending)
| Key | Object |
|---|---|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `as` | Scope |

### Parameter swapping
| Key | Action |
|---|---|
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |

### Insert mode
| Key | Action |
|---|---|
| `jj` | Escape to normal mode |

---

## Plugin Notes

### Colorscheme — `catppuccin/nvim`
Active theme. Set via `LazyVim/LazyVim` opts: `colorscheme = "catppuccin"`. Custom highlight overrides and integration flags are commented out in `colorscheme.lua` for reference.

### Formatter — `stevearc/conform.nvim`
- `markdown` and `html` → **prettier**
- JavaScript/TypeScript → **eslint** (run via `npx eslint --fix $FILENAME`, not stdin)
- ESLint root detection: looks for `eslint.config.mjs`, `.eslintrc`, or `package.json`

### LSP — `neovim/nvim-lspconfig`
Active servers:
- **eslint** — formatting enabled; tsserver formatting disabled when eslint attaches
- **marksman** — markdown; MD013 (line length) rule disabled
- **stylelint_lsp** — CSS/SCSS/Less formatting enabled
- **tailwindcss** — custom `classRegex` patterns for `cn()`, `cva()`, `classNames:{}`, and attribute-style `className=`

### File manager — `stevearc/oil.nvim`
Hidden files shown by default. Key: `<leader>fo`. Oil is loaded eagerly (`lazy = false`).

### Explorer — `folke/snacks.nvim`
- File tree with hidden files and follow-file enabled.
- Grep uses `rg --vimgrep --no-heading --smart-case`.
- Custom actions in the explorer:
  - `<leader>fo` → open current item's directory in Oil
  - `Y` → yank path (interactive: full, relative, dir, filename, dirname)
- Registered projects: `~/Projects/trisk/core/web`, `~/Projects/trisk/helpers`, `~/Projects/trisk/landing`

### Git diff — `sindrets/diffview.nvim`
| Key | Action |
|---|---|
| `<leader>dv` | Open diffview |
| `<leader>dh` | File history |
| `<leader>dx` | Close diffview |
| `<leader>db` | Pick branch to diff against |
| `<leader>dl` | Log |
| `<leader>ds` | Staged changes |

### TreeSJ — `Wansmer/treesj`
Default `<space>m/j/s` bindings removed. Use `<leader>ct` to toggle split/join.

### Tmux navigator — `christoomey/vim-tmux-navigator`
`<C-h/j/k/l>` navigate across Neovim splits and tmux panes seamlessly.

### Flash — `folke/flash.nvim`
`S` in operator-pending and visual mode is unbound (keeps LazyVim's `s` for normal mode flash).

### Disabled plugins
- `nvim-mini/mini.ai` — disabled in `disable-plugins.lua`

---

## Code Style

Formatting is enforced by **StyLua** (`stylua.toml`):

```toml
indent_type = "Spaces"
indent_width = 2
column_width = 120
```

- 2-space indentation, no tabs.
- Lines up to 120 characters.
- Use `-- stylua: ignore` on a line to exempt it from formatting.

When writing plugin specs, prefer `opts = function(_, opts) ... end` over plain `opts = {}` when you need to extend inherited configuration.

---

## Adding a New Plugin

1. Create `lua/plugins/<name>.lua`.
2. Return a valid lazy.nvim spec table.
3. Use `event = "VeryLazy"` for plugins that don't need to load at startup.
4. Pin a version with `version = "^x.y.z"` only when stability is critical (e.g., `nvim-surround`).
5. Run `:Lazy sync` inside Neovim to install; commit the updated `lazy-lock.json`.

---

## Disabling a Plugin

Add an entry to `lua/plugins/disable-plugins.lua`:

```lua
return {
  { "author/plugin-name", enabled = false },
}
```

---

## Workflow

- **Format code**: `<leader>ce` (LSP format) or `:conform` for conform.nvim.
- **Autoformat**: disabled globally; enable per-buffer with `:set autoformat`.
- **Update plugins**: `:Lazy update` then commit `lazy-lock.json`.
- **Manage extras**: `:LazyExtras` then commit `lazyvim.json`.
- **Check LSP status**: `:LspInfo`, `:Mason`.

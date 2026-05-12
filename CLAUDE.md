# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim configuration built on top of the [LazyVim](https://www.lazyvim.org/) starter. The entire bootstrap is two lines in `init.lua` → `lua/config/lazy.lua`, which clones lazy.nvim if missing and then loads:

1. `LazyVim/LazyVim` (the distro) — provides defaults for options, keymaps, autocmds, and a curated set of plugins.
2. `{ import = "plugins" }` — every file in `lua/plugins/*.lua` is a plugin spec that **extends or overrides** the LazyVim defaults.

Treat the codebase as a thin override layer, not a from-scratch config. Before adding anything, check whether LazyVim already provides it (the upstream defaults live in the `LazyVim/LazyVim` repo on GitHub).

## Directory layout (non-obvious bits)

- `lua/config/` — Neovim-level config loaded by lazy.nvim itself (`options.lua`, `keymaps.lua`, `autocmds.lua`). These run before `VeryLazy` for options, on `VeryLazy` for keymaps/autocmds — LazyVim handles the timing.
- `lua/plugins/` — one file per plugin (or per cluster of related plugins). Each returns a lazy.nvim spec or list of specs. Files are auto-imported, so filename is cosmetic.
- `lua/util/` — pure-Lua helpers `require`-d from keymaps/autocmds. Keep this side-effect-free; do not register autocmds or keymaps here.
- `lua/keymaps/` — filetype-scoped keymap registrations triggered from `lua/config/keymaps.lua` via `require("keymaps.snippets")`. Each module installs its own `FileType` autocmd internally.
- `snippets/` — VS Code-style JSON snippets registered for JS/TS via `snippets/package.json` (LazyVim's `friendly-snippets` mechanism picks this up).
- `lazyvim.json` — controls which LazyVim **extras** (`lazyvim.plugins.extras.*`) are enabled. This is the canonical way to add language/tooling support (e.g. typescript, tailwind, prisma). Edit this file, do **not** hand-write a plugin spec for an extra LazyVim already ships.
- `lazy-lock.json` — lazy.nvim's pinned commits per plugin. Updated by `:Lazy sync` / `:Lazy update`.
- `.neoconf.json` — enables neodev/neoconf so `lua_ls` understands the Neovim API and plugin sources. Lua completions in this repo depend on it.
- `stylua.toml` — Lua formatter config (2-space indent, 120-column line width). Run `stylua .` before committing Lua changes.

## Commands

- `nvim` — open the config; lazy.nvim auto-installs missing plugins on first run.
- `:Lazy` — open the plugin manager UI. `:Lazy sync` / `:Lazy update` / `:Lazy check` for batch operations.
- `:Mason` — manage LSP servers / formatters / linters / DAPs installed under `stdpath("data")/mason`.
- `:checkhealth` — diagnose plugin/LSP issues.
- `stylua .` — format all Lua files according to `stylua.toml`.
- Headless plugin sync (useful in scripts): `nvim --headless "+Lazy! sync" +qa`.

There is no test suite.

## Architecture notes that will save you time

### Formatting: ESLint LSP owns JS/TS

- `vim.g.autoformat = false` — format-on-save is disabled globally. Formatting is explicit via `<leader>cf` (mapped to `util.format.buffer_format`).
- `lua/config/autocmds.lua` strips `documentFormattingProvider` from `tsserver` / `vtsls` on `LspAttach`. This is intentional: ESLint LSP is the single source of truth for JS/TS formatting.
- `util/format.lua` dispatches: JS/TS filetypes → `:LspEslintFixAll`; everything else → `LazyVim.format({ force = true })` (which goes through conform.nvim → prettier/prettierd or LSP fallback).
- `lua/plugins/conform.lua` does **not** override JS/TS — that's deliberate (it was previously a bug). Only configures prettier for markdown/html/css/scss/json/yaml.

### Stylelint LSP is installed manually

`mason-lspconfig` still maps `stylelint_lsp` to the deprecated `stylelint-lsp` package. The workaround in `lua/plugins/nvim-lspconfig.lua` sets `mason = false` for `stylelint_lsp`, and `lua/plugins/mason.lua` ensures the correct `stylelint-language-server` package is installed instead. Don't "fix" this by enabling Mason auto-install for `stylelint_lsp` — it will pull the wrong binary.

### Completion / pairs / indent stack

- Completion: `blink.cmp` (replaces the LazyVim default of nvim-cmp via the LazyVim extra mechanism). Ghost text and signature help are on; cmdline completion uses `buffer` for `/`/`?` and `cmdline` otherwise.
- Pairs: `blink.pairs` (mini.pairs is explicitly **disabled** in `mini-overrides.lua`).
- Indent guides: `blink.indent` with scope highlighting (mini.indentscope is **disabled**).
- `mini.ai` has its `t` (tag) text object disabled, restoring native `vat`/`vit` behaviour for HTML/JSX — `mini.ai`'s implementation breaks JSX tags.

### File navigation

Two complementary tools:
- **snacks.nvim explorer** (sidebar tree) — `<leader>e` (LazyVim default) opens it; many custom keymaps in `lua/plugins/snacks.lua` including `Y` for the "yank path part" picker (full / relative / dir / basename) and `<leader>fo` to jump from the tree into oil for the current dir.
- **oil.nvim** (buffer-as-directory editor) — `<leader>fo` opens oil at the current file's directory. Inside oil, `-` goes up, `<CR>` opens, `<C-s>` / `<C-h>` open in splits.

### Window / tmux navigation

- `<C-h/j/k/l>` are claimed by `vim-tmux-navigator` for seamless tmux-pane switching.
- `<C-Arrow>` and `<C-S-Arrow>` are used for plain Vim window navigation/resizing (see `lua/config/keymaps.lua`). When adding new bindings, don't collide with these or with LazyVim's `<leader>` namespace defaults.
- `<S-h>` and `<S-l>` are explicitly **deleted** in `keymaps.lua`. `<Tab>` / `<S-Tab>` are the buffer cycling bindings instead.

### Custom snippet helper

`lua/util/snippets/log.lua` exposes `console_log_below_selection`, registered as `<leader>cnl` (visual mode) for JS/TS filetypes via `lua/keymaps/snippets.lua`. It inserts a `console.log('<selection>:<line>', <selection>);` line beneath the visual selection. JSON snippet equivalent (`clog` prefix) lives in `snippets/javascript.json`.

## Working with this codebase

- When adding a new plugin: create `lua/plugins/<name>.lua` returning a spec; lazy.nvim picks it up automatically on next start. Prefer `opts = function(_, opts) ... end` over `opts = {}` when extending an upstream LazyVim default — pure-table `opts` will replace, not merge.
- When enabling a language: edit `lazyvim.json` `extras` array first. Only drop down to a custom plugin file if the LazyVim extra is missing or insufficient.
- After changing plugins, run `:Lazy sync` and commit the updated `lazy-lock.json` together with the plugin spec change (the lockfile pins exact commits).
- The runtime working directory at the start of a session is `/home/oleksandrbilostotsk/.config/nvim`. The user typically edits this config from inside Neovim itself — be careful with operations that could break the running editor.

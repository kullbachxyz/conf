# Neovim Config

Leader key: `Space`

## Files

| File | Description |
|------|-------------|
| `init.lua` | Main config |
| `spell/custom.utf-8.add` | Personal word list (all languages) |

## Plugins

Managed with [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-installed on first launch).

| Plugin | Purpose |
|--------|---------|
| `NvChad/nvim-colorizer.lua` | Highlight hex color codes inline |

## Spellcheck

Enabled automatically for `markdown`, `text`, `gitcommit`, and `tex` files.
Languages: German (`de`) + English (`en_us`).

Words added with `<leader>sa` are saved to `spell/custom.utf-8.add` — a single
language-agnostic file recognized regardless of which language is active.

| Key          | Action                  |
|--------------|-------------------------|
| `<leader>st` | Toggle spellcheck       |
| `<leader>sn` | Next misspelling        |
| `<leader>sp` | Previous misspelling    |
| `<leader>ss` | Suggest corrections     |
| `<leader>sa` | Add word to dictionary  |
| `<leader>sw` | Mark word as wrong      |
